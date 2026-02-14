#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "nokogiri"
require "open-uri"
require "time"
require "uri"
require "yaml"
require_relative "podcast_feed_item_helpers"

class PodcastFeedImporter
  USER_AGENT = "mikemcquaid.com"
  SOURCES_FILE = "_data/podcast_sources.yml"
  OUTPUT_FILE = "_data/podcasts_external.yml"
  REQUIRED_FIELDS = %w[title date podcast_audio_url].freeze

  def initialize
    @sources = load_sources
  end

  def run
    existing_items = load_existing_items
    items = []

    @sources.each do |source|
      feed_url = source.fetch("feed_url")
      source_existing_items = existing_items_for_source(existing_items, source)

      if source_existing_items.any? && source_complete?(source_existing_items)
        items.concat(source_existing_items)
        next
      end

      items.concat(fetch_feed_items(feed_url, source))
    rescue OpenURI::HTTPError => e
      warn "podcast-feed-importer: skipping #{feed_url}: #{e.message}"
      items.concat(source_existing_items || [])
    end

    items = deduplicate_items(items)
    items.sort_by! { |item| -item.fetch("sort_unix", 0).to_i }

    output = { "items" => items }
    output_yaml = YAML.dump(output)
    existing_yaml = File.exist?(OUTPUT_FILE) ? File.read(OUTPUT_FILE) : ""

    if output_yaml == existing_yaml
      return
    end

    File.write(OUTPUT_FILE, output_yaml)
    warn "podcast-feed-importer: wrote #{items.length} items to #{OUTPUT_FILE}"
  end

  private

  def load_existing_items
    return [] unless File.exist?(OUTPUT_FILE)

    data = YAML.safe_load_file(OUTPUT_FILE, permitted_classes: [], aliases: true) || {}
    Array(data["items"])
  end

  def load_sources
    data = YAML.safe_load_file(SOURCES_FILE, permitted_classes: [], aliases: true) || {}
    defaults = data.fetch("defaults", {})
    sources = data.fetch("sources", []).map do |source|
      source_data = case source
      when String
        { "feed_url" => source }
      when Hash
        source
      else
        raise "#{SOURCES_FILE} source must be a mapping or feed URL string."
      end
      defaults.merge(source_data)
    end
    raise "#{SOURCES_FILE} has no sources." if sources.empty?

    sources.each do |source|
      feed_url = source["feed_url"].to_s.strip
      raise "#{SOURCES_FILE} source missing feed_url." if feed_url.empty?
    end

    sources
  end

  def fetch_feed_items(feed_url, source)
    xml = URI.open(feed_url, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::XML(xml)
    doc.remove_namespaces!

    publication = source["title"].to_s.strip
    if publication.empty?
      publication = PodcastFeedItemHelpers.text_at(doc, "/rss/channel/title")
      publication = PodcastFeedItemHelpers.text_at(doc, "/feed/title") if publication.empty?
    end

    item_nodes = PodcastFeedItemHelpers.feed_items(doc)

    item_nodes.each_with_object([]) do |item, all_items|
      parsed = parse_item(item, publication, feed_url)
      all_items << parsed if parsed
    end
  end

  def parse_item(item, publication, feed_url)
    title = PodcastFeedItemHelpers.text_at(item, "./title")
    link = PodcastFeedItemHelpers.item_link(item)
    description = PodcastFeedItemHelpers.text_at(item, "./description")
    description = PodcastFeedItemHelpers.text_at(item, "./summary") if description.empty?
    description = PodcastFeedItemHelpers.text_at(item, "./content") if description.empty?
    guid = PodcastFeedItemHelpers.text_at(item, "./guid")
    guid = PodcastFeedItemHelpers.text_at(item, "./id") if guid.empty?

    published = parse_time(
      PodcastFeedItemHelpers.text_at(item, "./pubDate"),
      PodcastFeedItemHelpers.text_at(item, "./published"),
      PodcastFeedItemHelpers.text_at(item, "./updated")
    )
    return nil if title.empty? || published.nil?

    audio = PodcastFeedItemHelpers.audio_data(item)
    item_id = if guid.empty?
      digest_source = [feed_url, link, title, published.iso8601].join("\n")
      "external:#{Digest::SHA256.hexdigest(digest_source)}"
    else
      guid
    end

    compact_item(
      {
        "id" => item_id,
        "source_feed_url" => feed_url,
        "title" => title,
        "link" => link,
        "description" => description,
        "publication" => publication,
        "date" => published.utc.iso8601,
        "sort_unix" => published.to_i,
        "guid" => guid,
        "podcast_audio_url" => audio.fetch(:url),
        "podcast_audio_type" => audio.fetch(:type),
        "podcast_audio_length" => audio.fetch(:length)
      }
    )
  end

  def source_complete?(items)
    return false if items.empty?

    items.all? do |item|
      REQUIRED_FIELDS.all? do |field|
        !item[field].to_s.strip.empty?
      end
    end
  end

  def existing_items_for_source(existing_items, source)
    feed_url = source["feed_url"].to_s.strip
    publication = source["title"].to_s.strip

    existing_items.select do |item|
      source_feed_url = item["source_feed_url"].to_s.strip
      next true if !source_feed_url.empty? && source_feed_url == feed_url

      source_feed_url.empty? && !publication.empty? && item["publication"].to_s.strip == publication
    end
  end

  def parse_time(*values)
    values.each do |value|
      text = value.to_s.strip
      next if text.empty?

      return Time.parse(text)
    rescue ArgumentError
      next
    end
    nil
  end

  def deduplicate_items(items)
    seen = {}

    items.each_with_object([]) do |item, deduplicated|
      key = [
        item["podcast_audio_url"].to_s.strip,
        item["guid"].to_s.strip,
        item["link"].to_s.strip,
        item["id"].to_s.strip
      ].find { |value| !value.empty? }
      next if key.nil? || seen[key]

      seen[key] = true
      deduplicated << item
    end
  end

  def compact_item(item)
    compacted = item.each_with_object({}) do |(key, value), memo|
      next if value.nil?
      next if value.is_a?(String) && value.strip.empty?

      memo[key] = value
    end
    if compacted["podcast_audio_type"] == "audio/mpeg"
      compacted.delete("podcast_audio_type")
    end
    compacted
  end
end

if __FILE__ == $PROGRAM_NAME
  PodcastFeedImporter.new.run
end
