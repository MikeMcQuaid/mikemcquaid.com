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
    link_image = data["link_image"].to_s.strip
    return false if !link_title.empty? && !link_description.empty? && !link_image.empty?

    metadata = fetch(link)
    return false unless metadata

    data["link_title"] = metadata.fetch(:title) if link_title.empty?
    data["link_description"] = metadata.fetch(:description) if link_description.empty?
    data["link_image"] = metadata.fetch(:image) if link_image.empty? && !metadata.fetch(:image).empty?

    true
  end

  def self.run(paths = nil)
    paths = Dir.glob("_thoughts/*.md") if paths.nil? || paths.empty?
    updated = false

    paths.each do |path|
      content = File.read(path)
      data, body = parse_frontmatter(content)
      next unless data

      next unless enrich_data!(data)

      File.write(path, render_frontmatter(data, body))
      updated = true
    end

    warn "thought-link-metadata: added link metadata to thoughts." if updated
  end

  def self.fetch(link)
    html = URI.open(link, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)

    title = doc.at('meta[property="og:title"]')&.[]("content").to_s.strip
    title = doc.at("title")&.text.to_s.strip if title.empty?

    description = doc.at('meta[property="og:description"]')&.[]("content").to_s.strip
    description = doc.at('meta[name="description"]')&.[]("content").to_s.strip if description.empty?

    image = doc.at('meta[property="og:image"]')&.[]("content").to_s.strip
    image = URI.join(link, image).to_s if image != ""

    return if title.empty? && description.empty? && image.empty?

    { title:, description:, image: }
  end

  def self.parse_frontmatter(content)
    match = content.match(Jekyll::Document::YAML_FRONT_MATTER_REGEXP)
    return [nil, content] unless match

    data = YAML.safe_load(match[1], permitted_classes: [], aliases: true) || {}
    body = content[match.end(0)..]
    [data, body]
  end

  def self.render_frontmatter(data, body)
    frontmatter = YAML.dump(data).sub(/\A---\s*\n/, "")
    +"---\n#{frontmatter}---\n#{body}"
  end

end
