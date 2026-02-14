# frozen_string_literal: true

require "open-uri"
require "open3"
require "jekyll"
require "json"
require "net/http"
require "nokogiri"
require "uri"
require "yaml"
require_relative "podcast_feed_item_helpers"

module ContentLinkMetadata
  USER_AGENT = "mikemcquaid.com"
  SINGLE_LINE_QUOTED_FIELDS = %w[title link_title link_description].freeze
  PRESERVE_EXISTING_FIELDS = %w[title publication link_title link_image link_description].freeze
  THOUGHT_ENRICHMENT_FIELDS = %w[link_title link_description link_image].freeze
  INTERVIEW_ENRICHMENT_FIELDS = %w[
    link_image
    link_description
    youtube-id
    podcast_audio_url
    podcast_audio_type
    podcast_audio_length
  ].freeze

  def self.enrich_data!(data, path: nil)
    link = data["link"].to_s.strip
    return false if link.empty?

    updated = false

    title_present = data.key?("link_title")
    link_description_present = data.key?("link_description")
    link_image_present = data.key?("link_image")
    title = normalize_text(data["link_title"])
    link_description = normalize_text(data["link_description"])
    link_image = data["link_image"].to_s.strip

    return updated if !title.empty? && !link_description.empty? && !link_image.empty?

    metadata = fetch(link, path: path)
    return updated unless metadata

    if !title_present && title.empty? && !metadata.fetch(:title).empty?
      data["link_title"] = metadata.fetch(:title)
      updated = true
    end
    if !link_description_present && link_description.empty? && !metadata.fetch(:description).empty?
      data["link_description"] = metadata.fetch(:description)
      updated = true
    end
    if !link_image_present && link_image.empty? && !metadata.fetch(:image).empty?
      data["link_image"] = metadata.fetch(:image)
      updated = true
    end

    updated
  end

  def self.enrich_interview_data!(data, body, path: nil)
    updated = false

    title_present = data.key?("title")
    link_image_present = data.key?("link_image")
    link_description_present = data.key?("link_description")
    title = normalize_text(data["title"])
    link_image = data["link_image"].to_s.strip
    link_description = normalize_text(data["link_description"])

    youtube_id_raw = data["youtube-id"]
    youtube_id = youtube_id_raw.to_s.strip
    if !youtube_id_raw.nil? && youtube_id != youtube_id_raw.to_s
      data["youtube-id"] = youtube_id
      updated = true
    end

    podcast_audio_url_raw = data["podcast_audio_url"]
    podcast_audio_url = podcast_audio_url_raw.to_s.strip
    if !podcast_audio_url_raw.nil? && podcast_audio_url != podcast_audio_url_raw.to_s
      data["podcast_audio_url"] = podcast_audio_url
      updated = true
    end

    podcast_audio_type_raw = data["podcast_audio_type"]
    podcast_audio_type = podcast_audio_type_raw.to_s.strip
    if !podcast_audio_type_raw.nil? && podcast_audio_type != podcast_audio_type_raw.to_s
      data["podcast_audio_type"] = podcast_audio_type
      updated = true
    end

    podcast_audio_length_raw = data["podcast_audio_length"]
    podcast_audio_length = podcast_audio_length_raw.to_s.strip
    if !podcast_audio_length_raw.nil? && podcast_audio_length != podcast_audio_length_raw.to_s
      data["podcast_audio_length"] = podcast_audio_length
      updated = true
    end

    podcast_feed_url_removed = !data.delete("podcast_feed_url").nil?
    podcast_duration_removed = !data.delete("podcast_duration").nil?
    podcast_removed = !data.delete("podcast").nil?
    updated = true if podcast_feed_url_removed || podcast_duration_removed || podcast_removed

    interview_body = body.to_s
    if normalize_text(interview_body).empty? && !link_description.empty?
      interview_body = "#{link_description}\n"
      updated = true
    end

    link = data["link"].to_s.strip
    return [updated, interview_body] if link.empty?

    has_body = !normalize_text(interview_body).empty?
    has_youtube = !youtube_id.empty?
    has_podcast_audio = !podcast_audio_url.empty?
    return [updated, interview_body] if !title.empty? && !link_image.empty? && has_youtube && has_podcast_audio

    metadata = fetch(link, include_audio_metadata: true, path: path)
    return [updated, interview_body] unless metadata

    if !title_present && title.empty? && !metadata.fetch(:title).empty?
      data["title"] = metadata.fetch(:title)
      updated = true
    end

    if !link_image_present && link_image.empty? && !metadata.fetch(:image).empty?
      data["link_image"] = metadata.fetch(:image)
      updated = true
    end

    if !link_description_present && !has_body && !metadata.fetch(:description).empty?
      interview_body = "#{metadata.fetch(:description)}\n"
      updated = true
    end

    if youtube_id.empty? && !metadata.fetch(:youtube_id).empty?
      data["youtube-id"] = metadata.fetch(:youtube_id)
      updated = true
    end

    podcast_audio_url = data["podcast_audio_url"].to_s.strip
    if podcast_audio_url.empty? && !metadata.fetch(:podcast_audio_url).empty?
      data["podcast_audio_url"] = metadata.fetch(:podcast_audio_url)
      updated = true
      podcast_audio_url = data["podcast_audio_url"].to_s.strip
    end

    if data["podcast_audio_type"].to_s.strip.empty? && !metadata.fetch(:podcast_audio_type).empty?
      data["podcast_audio_type"] = metadata.fetch(:podcast_audio_type)
      updated = true
    end

    if data["podcast_audio_length"].to_s.strip.empty? && !metadata.fetch(:podcast_audio_length).empty?
      data["podcast_audio_length"] = metadata.fetch(:podcast_audio_length)
      updated = true
    end

    [updated, interview_body]
  end

  def self.run(paths = nil)
    @fetch_cache = {}
    @podcast_feed_doc_cache = {}
    @head_frontmatter_cache = {}

    if paths.nil? || paths.empty?
      paths = Dir.glob("_thoughts/*.md") + Dir.glob("_interviews/*.md")
    end
    updated = false

    paths.each do |path|
      content = File.read(path)
      data, body, raw_frontmatter = parse_frontmatter(content)
      next unless data

      begin
        next if skip_incremental_enrichment?(path, data)

        rendered_body = if interview_path?(path)
          _, updated_body = enrich_interview_data!(data, body, path: path)
          updated_body
        else
          enrich_data!(data, path: path)
          body
        end

        preserved_lines = preserved_frontmatter_lines(raw_frontmatter)
        rendered_content = render_frontmatter(data, rendered_body, preserved_lines: preserved_lines)
        next if rendered_content == content

        File.write(path, rendered_content)
        updated = true
      rescue OpenURI::HTTPError => e
        warn "content-link-metadata: #{path}: #{e.message}"
        next
      rescue StandardError => e
        warn "content-link-metadata: #{path}: #{e.class}: #{e.message}"
        next
      end
    end

    updated
  end

  def self.skip_incremental_enrichment?(path, data)
    link = data["link"].to_s.strip
    return false if link.empty?

    previous_data = head_frontmatter(path)
    return false unless previous_data

    previous_link = previous_data["link"].to_s.strip
    return false if previous_link.empty? || previous_link != link

    enrichment_fields(path).any? { |field| previous_data.key?(field) }
  end

  def self.enrichment_fields(path)
    interview_path?(path) ? INTERVIEW_ENRICHMENT_FIELDS : THOUGHT_ENRICHMENT_FIELDS
  end

  def self.head_frontmatter(path)
    return @head_frontmatter_cache[path] if @head_frontmatter_cache.key?(path)

    output, status = Open3.capture2("git", "show", "HEAD:#{path}")
    unless status.success?
      @head_frontmatter_cache[path] = nil
      return nil
    end

    previous_data, = parse_frontmatter(output)
    @head_frontmatter_cache[path] = previous_data
  rescue StandardError
    @head_frontmatter_cache[path] = nil
  end

  def self.fetch(link, include_audio_metadata: false, path: nil)
    cache_key = [link, include_audio_metadata]
    cached = @fetch_cache&.fetch(cache_key, :__none__)
    return nil if cached.nil?
    raise cached if cached.is_a?(OpenURI::HTTPError)
    return cached unless cached == :__none__

    log_stage(path, "reading linked page #{link}")
    html = URI.open(link, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)

    title = normalize_text(doc.at('meta[property="og:title"]')&.[]("content"))
    title = normalize_text(doc.at("title")&.text) if title.empty?

    description = normalize_text(doc.at('meta[property="og:description"]')&.[]("content"))
    description = normalize_text(doc.at('meta[name="description"]')&.[]("content")) if description.empty?

    image = doc.at('meta[property="og:image"]')&.[]("content").to_s.strip
    image = https_image_url(link, image)

    youtube_id = include_audio_metadata ? youtube_id_from_page(doc) : ""
    podcast_data = if include_audio_metadata
      podcast_data_from_page(link, doc, title, path: path)
    else
      {
        podcast_audio_url: "",
        podcast_audio_type: "",
        podcast_audio_length: ""
      }
    end
    podcast_audio_url = podcast_data.fetch(:podcast_audio_url)
    podcast_audio_type = podcast_data.fetch(:podcast_audio_type)
    podcast_audio_length = podcast_data.fetch(:podcast_audio_length)
    if include_audio_metadata && (!youtube_id.empty? || !podcast_audio_url.empty?)
      log_stage(path, "found media youtube-id=#{youtube_id.empty? ? "-" : youtube_id} podcast_audio_url=#{podcast_audio_url.empty? ? "-" : podcast_audio_url}")
    end

    result = if title.empty? &&
                description.empty? &&
                image.empty? &&
                youtube_id.empty? &&
                podcast_audio_url.empty?
      nil
    else
      {
        title: title,
        description: description,
        image: image,
        youtube_id: youtube_id,
        podcast_audio_url: podcast_audio_url,
        podcast_audio_type: podcast_audio_type,
        podcast_audio_length: podcast_audio_length
      }
    end

    @fetch_cache[cache_key] = result if @fetch_cache
    result
  rescue OpenURI::HTTPError => e
    @fetch_cache[cache_key] = e if @fetch_cache
    raise
  end

  def self.normalize_text(text)
    text.to_s.gsub(/\s+/, " ").strip
  end

  def self.https_image_url(link, image)
    image = image.to_s.strip
    return "" if image.empty?

    absolute = begin
      URI.join(link, image).to_s
    rescue URI::InvalidURIError
      ""
    end
    return "" if absolute.empty?

    uri = URI.parse(absolute)
    return "" unless uri.scheme&.downcase == "http" || uri.scheme&.downcase == "https"

    uri.scheme = "https"
    https_url = uri.to_s

    return https_url if https_url_working?(https_url)

    ""
  rescue URI::InvalidURIError
    ""
  end

  def self.https_url_working?(url)
    uri = URI.parse(url)
    limit = 5

    while limit.positive?
      response = net_http_request(uri, Net::HTTP::Head.new(uri.request_uri))
      case response
      when Net::HTTPRedirection
        location = response["location"].to_s
        return false if location.empty?

        uri = URI.join(uri.to_s, location)
        return false unless uri.scheme&.downcase == "https"
      when Net::HTTPMethodNotAllowed
        response = net_http_request(uri, Net::HTTP::Get.new(uri.request_uri, "Range" => "bytes=0-0"))
        return response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPPartialContent)
      else
        return response.is_a?(Net::HTTPSuccess)
      end

      limit -= 1
    end

    false
  rescue URI::InvalidURIError
    false
  end

  def self.net_http_request(uri, request)
    request["User-Agent"] ||= USER_AGENT
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end
  end

  def self.parse_frontmatter(content)
    match = content.match(Jekyll::Document::YAML_FRONT_MATTER_REGEXP)
    return [nil, content, ""] unless match

    data = YAML.safe_load(match[1], permitted_classes: [], aliases: true) || {}
    body = content[match.end(0)..]
    [data, body, match[1].to_s]
  end

  def self.preserved_frontmatter_lines(raw_frontmatter)
    lines = {}
    raw_frontmatter.to_s.each_line do |line|
      stripped = line.chomp
      next if stripped.empty?

      if (match = stripped.match(/\A([A-Za-z0-9_-]+):\s*(.*)\z/))
        key = match[1]
        next unless PRESERVE_EXISTING_FIELDS.include?(key)

        lines[key] = stripped
      end
    end
    lines
  end

  def self.render_frontmatter(data, body, preserved_lines: {})
    lines = ["---"]
    data.each do |key, value|
      key_string = key.to_s
      if preserved_lines[key_string]
        lines << preserved_lines[key_string]
      else
        lines.concat(render_frontmatter_entry(key, value))
      end
    end
    lines << "---"
    +"#{lines.join("\n")}\n#{body}"
  end

  def self.interview_path?(path)
    path = path.to_s
    path.start_with?("_interviews/") || path.include?("/_interviews/")
  end

  def self.render_frontmatter_entry(key, value)
    key = key.to_s

    if key == "link"
      return ["link: #{normalize_text(value)}"]
    end

    if SINGLE_LINE_QUOTED_FIELDS.include?(key)
      single_line = normalize_text(value)
      return ["#{key}: #{single_line.dump}"]
    end

    rendered = YAML.dump({ key => value }).sub(/\A---\s*\n/, "").rstrip
    rendered.lines(chomp: true)
  end

  def self.podcast_data_from_page(link, doc, page_title, path: nil)
    podcast_data = {
      podcast_audio_url: "",
      podcast_audio_type: "",
      podcast_audio_length: ""
    }

    direct_audio = first_audio_url_from_doc(link, doc)
    if !direct_audio.empty?
      log_stage(path, "validating podcast audio URL #{direct_audio}")
    end
    if !direct_audio.empty? && downloadable_url?(direct_audio)
      podcast_data[:podcast_audio_url] = direct_audio
      podcast_data[:podcast_audio_type] = "audio/mpeg" if podcast_data[:podcast_audio_type].empty?
      log_stage(path, "podcast audio URL is downloadable")
    elsif !direct_audio.empty?
      log_stage(path, "podcast audio URL is not downloadable")
    end

    podcast_feed_urls_from_doc(link, doc).each do |feed_url|
      feed_item = podcast_feed_item(feed_url, link, page_title)
      next unless feed_item

      if podcast_data[:podcast_audio_url].empty?
        candidate_audio = feed_item[:audio_url].to_s
        unless candidate_audio.empty?
          log_stage(path, "validating feed podcast audio URL #{candidate_audio}")
        end

        if downloadable_url?(candidate_audio)
          podcast_data[:podcast_audio_url] = candidate_audio
          log_stage(path, "feed podcast audio URL is downloadable")
        elsif !candidate_audio.empty?
          log_stage(path, "feed podcast audio URL is not downloadable")
        end
      end
      podcast_data[:podcast_audio_type] = feed_item[:audio_type] if podcast_data[:podcast_audio_type].empty?
      podcast_data[:podcast_audio_length] = feed_item[:audio_length] if podcast_data[:podcast_audio_length].empty?
      break
    rescue OpenURI::HTTPError, RuntimeError
      next
    end

    podcast_data
  end

  def self.podcast_feed_urls_from_doc(link, doc)
    urls = []

    link_nodes = doc.css("link[rel='alternate'][type], link[rel='alternate'][href]")
    link_nodes.each do |node|
      type = node["type"].to_s.downcase
      href = node["href"].to_s.strip
      next if href.empty?
      next unless type.include?("rss") || type.include?("atom") || type.include?("xml")

      absolute = absolute_http_url(link, href)
      urls << absolute unless absolute.empty?
    end

    doc.css("a[href]").each do |node|
      href = node["href"].to_s.strip
      next if href.empty?
      next unless href.match?(/(\.rss|\.xml|\/feed)(\?|$)/i)

      absolute = absolute_http_url(link, href)
      urls << absolute unless absolute.empty?
    end

    urls.uniq
  end

  def self.first_audio_url_from_doc(link, doc)
    hrefs = []
    doc.css("a[href]").each { |node| hrefs << node["href"].to_s.strip }
    doc.css("audio[src], source[src]").each { |node| hrefs << node["src"].to_s.strip }

    hrefs.each do |href|
      next if href.empty?
      next unless href.match?(/\.(mp3|m4a|aac|ogg|wav)(\?|$)/i)

      absolute = absolute_http_url(link, href)
      return absolute unless absolute.empty?
    end

    ""
  end

  def self.podcast_feed_item(feed_url, page_link, page_title)
    cached = @podcast_feed_doc_cache&.[](feed_url)
    raise cached if cached.is_a?(OpenURI::HTTPError)

    doc = cached
    unless doc
      xml = URI.open(feed_url, "User-Agent" => USER_AGENT).read
      doc = Nokogiri::XML(xml)
      doc.remove_namespaces!
      @podcast_feed_doc_cache[feed_url] = doc if @podcast_feed_doc_cache
    end

    items = PodcastFeedItemHelpers.feed_items(doc)
    return if items.empty?

    normalized_page_link = normalize_url_for_match(page_link)
    normalized_page_title = normalize_title_for_match(page_title)

    best_item = nil
    best_score = -1

    items.each do |item|
      score = podcast_item_match_score(item, normalized_page_link, normalized_page_title)
      next if score <= best_score

      best_score = score
      best_item = item
    end
    return if best_item.nil? || best_score < 2

    audio = PodcastFeedItemHelpers.audio_data(best_item)
    {
      audio_url: audio.fetch(:url),
      audio_type: audio.fetch(:type),
      audio_length: audio.fetch(:length)
    }
  rescue OpenURI::HTTPError => e
    @podcast_feed_doc_cache[feed_url] = e if @podcast_feed_doc_cache
    raise
  end

  def self.podcast_item_match_score(item, normalized_page_link, normalized_page_title)
    item_link = PodcastFeedItemHelpers.item_link(item)
    normalized_item_link = normalize_url_for_match(item_link)
    item_title = normalize_title_for_match(item.at_xpath("./title")&.text.to_s)

    score = 0
    if !normalized_page_link.empty? && !normalized_item_link.empty?
      score += 5 if normalized_item_link == normalized_page_link
      score += 3 if normalized_item_link.include?(normalized_page_link) || normalized_page_link.include?(normalized_item_link)
    end

    if !normalized_page_title.empty? && !item_title.empty?
      score += 4 if item_title == normalized_page_title
      score += 2 if item_title.include?(normalized_page_title) || normalized_page_title.include?(item_title)
      score += 1 if title_token_overlap?(item_title, normalized_page_title)
    end

    score
  end

  def self.title_token_overlap?(a, b)
    a_tokens = a.split(/[^a-z0-9]+/).reject(&:empty?).uniq
    b_tokens = b.split(/[^a-z0-9]+/).reject(&:empty?).uniq
    return false if a_tokens.empty? || b_tokens.empty?

    overlap = a_tokens & b_tokens
    overlap.length >= [a_tokens.length, b_tokens.length].min / 2
  end

  def self.normalize_url_for_match(url)
    text = url.to_s.strip
    return "" if text.empty?

    uri = URI.parse(text)
    host = uri.host.to_s.downcase.sub(/\Awww\./, "")
    path = uri.path.to_s.sub(%r{/\z}, "")
    "#{host}#{path}"
  rescue URI::InvalidURIError
    text.downcase.sub(%r{/\z}, "")
  end

  def self.normalize_title_for_match(title)
    normalize_text(title).downcase
  end

  def self.youtube_id_from_page(doc)
    urls = []
    urls.concat(doc.css("a[href]").map { |node| node["href"].to_s.strip })
    urls.concat(doc.css("iframe[src]").map { |node| node["src"].to_s.strip })
    urls << doc.at('meta[property="og:video:url"]')&.[]("content").to_s.strip
    urls << doc.at('meta[property="og:video"]')&.[]("content").to_s.strip
    urls << doc.at('meta[name="twitter:player"]')&.[]("content").to_s.strip

    doc.css('script[type="application/ld+json"]').each do |node|
      json = node.text.to_s
      next if json.strip.empty?

      parsed = JSON.parse(json)
      youtube = youtube_id_from_json(parsed)
      return youtube unless youtube.empty?
    rescue JSON::ParserError
      next
    end

    urls.each do |url|
      youtube = extract_youtube_id(url)
      return youtube unless youtube.empty?
    end

    ""
  end

  def self.youtube_id_from_json(value)
    case value
    when Array
      value.each do |element|
        youtube = youtube_id_from_json(element)
        return youtube unless youtube.empty?
      end
    when Hash
      value.each_value do |v|
        youtube = youtube_id_from_json(v)
        return youtube unless youtube.empty?
      end
    when String
      youtube = extract_youtube_id(value)
      return youtube unless youtube.empty?
    end

    ""
  end

  def self.extract_youtube_id(url)
    text = url.to_s.strip
    return "" if text.empty?

    if (match = text.match(%r{youtu\.be/([A-Za-z0-9_-]{11})}i))
      return match[1]
    end
    if (match = text.match(%r{youtube(?:-nocookie)?\.com/embed/([A-Za-z0-9_-]{11})}i))
      return match[1]
    end
    if (match = text.match(/[?&]v=([A-Za-z0-9_-]{11})/i))
      return match[1]
    end

    ""
  end

  def self.absolute_http_url(base, candidate)
    absolute = URI.join(base, candidate).to_s
    uri = URI.parse(absolute)
    return "" unless uri.scheme&.downcase == "http" || uri.scheme&.downcase == "https"

    absolute
  rescue URI::InvalidURIError
    ""
  end

  def self.downloadable_url?(url)
    uri = URI.parse(url.to_s)
    return false unless uri.scheme&.downcase == "http" || uri.scheme&.downcase == "https"

    limit = 5
    while limit.positive?
      request_uri = uri.request_uri.to_s
      request_uri = "/" if request_uri.empty?

      head = net_http_request(uri, Net::HTTP::Head.new(request_uri))
      case head
      when Net::HTTPRedirection
        location = head["location"].to_s
        return false if location.empty?

        uri = URI.join(uri.to_s, location)
        return false unless uri.scheme&.downcase == "http" || uri.scheme&.downcase == "https"
      when Net::HTTPSuccess
        return true
      else
        get = net_http_request(uri, Net::HTTP::Get.new(request_uri, "Range" => "bytes=0-0"))
        return get.is_a?(Net::HTTPSuccess) || get.is_a?(Net::HTTPPartialContent)
      end

      limit -= 1
    end

    false
  rescue URI::InvalidURIError
    false
  end

  def self.log_stage(path, message)
    return if path.nil? || path.to_s.empty?

    warn "content-link-metadata: #{path}: #{message}"
  end

end
