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

    updated = false

    link_title_raw = data["link_title"]
    link_title = normalize_text(link_title_raw)
    if !link_title_raw.nil? && link_title != link_title_raw.to_s
      data["link_title"] = link_title
      updated = true
    end

    link_description_raw = data["link_description"]
    link_description = normalize_text(link_description_raw)
    if !link_description_raw.nil? && link_description != link_description_raw.to_s
      data["link_description"] = link_description
      updated = true
    end

    link_image_raw = data["link_image"]
    link_image = link_image_raw.to_s.strip
    if !link_image_raw.nil? && link_image != link_image_raw.to_s
      data["link_image"] = link_image
      updated = true
    end

    return updated if !link_title.empty? && !link_description.empty? && !link_image.empty?

    metadata = fetch(link)
    return updated unless metadata

    if link_title.empty?
      data["link_title"] = metadata.fetch(:title)
      updated = true
    end
    if link_description.empty?
      data["link_description"] = metadata.fetch(:description)
      updated = true
    end
    if link_image.empty? && !metadata.fetch(:image).empty?
      data["link_image"] = metadata.fetch(:image)
      updated = true
    end

    updated
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

    title = normalize_text(doc.at('meta[property="og:title"]')&.[]("content"))
    title = normalize_text(doc.at("title")&.text) if title.empty?

    description = normalize_text(doc.at('meta[property="og:description"]')&.[]("content"))
    description = normalize_text(doc.at('meta[name="description"]')&.[]("content")) if description.empty?

    image = doc.at('meta[property="og:image"]')&.[]("content").to_s.strip
    image = begin
      URI.join(link, image).to_s
    rescue URI::InvalidURIError
      ""
    end

    return if title.empty? && description.empty? && image.empty?

    { title:, description:, image: }
  end

  def self.normalize_text(text)
    text.to_s.gsub(/\s+/, " ").strip
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
