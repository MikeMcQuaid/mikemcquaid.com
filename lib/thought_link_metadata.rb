# frozen_string_literal: true

require "open-uri"
require "jekyll"
require "nokogiri"
require "uri"
require "yaml"

module ThoughtLinkMetadata
  USER_AGENT = "mikemcquaid.com"

  def self.enrich_data!(data)
    link = data["link"].to_s.strip
    return false if link.empty?

    link_title = data["link_title"].to_s.strip
    link_description = data["link_description"].to_s.strip
    return false if !link_title.empty? && !link_description.empty?

    metadata = fetch(link)
    return false unless metadata

    data["link_title"] = metadata.fetch(:title)
    data["link_description"] = metadata.fetch(:description)

    true
  end

  def self.run
    paths = Dir.glob("_thoughts/*.md")
    updated = false

    paths.each do |path|
      content = File.read(path)
      match = content.match(Jekyll::Document::YAML_FRONT_MATTER_REGEXP)
      next unless match

      data = YAML.safe_load(match[1], permitted_classes: [], aliases: true)
      body = content[match.end(0)..]
      next unless data

      next unless enrich_data!(data)

      frontmatter = YAML.dump(data).sub(/\A---\s*\n/, "")
      File.write(path, +"---\n#{frontmatter}---\n#{body}")
      updated = true
    end

    warn "thought-link-metadata: added link_title/link_description metadata to thoughts." if updated
  end

  def self.fetch(link)
    html = URI.open(link, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)

    title = doc.at('meta[property="og:title"]')&.[]("content").to_s.strip
    title = doc.at("title")&.text.to_s.strip if title.empty?

    description = doc.at('meta[property="og:description"]')&.[]("content").to_s.strip
    description = doc.at('meta[name="description"]')&.[]("content").to_s.strip if description.empty?

    return if title.empty? && description.empty?

    { title:, description: }
  end

end
