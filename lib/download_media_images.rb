#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "net/http"
require "uri"
require "yaml"

module DownloadMediaImages
  FRONTMATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
  USER_AGENT = "mikemcquaid.com"
  SINGLE_LINE_QUOTED_FIELDS = %w[title link_title link_description].freeze
  PRESERVE_EXISTING_FIELDS = %w[title publication link_title link_image link_description].freeze
  YOUTUBE_DIR = "images/media/youtube"
  SPEAKERDECK_DIR = "images/media/talks"
  THOUGHTS_DIR = "images/media/thoughts"
  INTERVIEWS_DIR = "images/media/interviews"
  YOUTUBE_WIDTH = 960
  LINK_IMAGE_WIDTH = 1200
  JPEG_QUALITY = 60

  def self.run
    ensure_directories

    updated = false
    each_content_file do |path, data, body, raw_frontmatter, content|
      updated |= download_youtube_for(data)
      updated |= download_speakerdeck_for(data)
      updated |= download_link_image_for(path, data, body, raw_frontmatter, content)
    end
    updated |= cleanup_orphaned_images
    updated
  end

  def self.run_for_paths(paths)
    return false if paths.nil? || paths.empty?

    ensure_directories

    updated = false
    paths.each do |path|
      next unless File.exist?(path)

      content = File.read(path)
      data, body, raw_frontmatter = parse_frontmatter(content)
      next unless data

      updated |= download_youtube_for(data)
      updated |= download_speakerdeck_for(data)
      updated |= download_link_image_for(path, data, body, raw_frontmatter, content)
    end
    updated
  end

  def self.ensure_directories
    [YOUTUBE_DIR, SPEAKERDECK_DIR, THOUGHTS_DIR, INTERVIEWS_DIR].each { |d| FileUtils.mkdir_p(d) }
  end

  def self.download_youtube_for(data)
    youtube_id = data["youtube-id"].to_s.strip
    return false if youtube_id.empty?

    path = "#{YOUTUBE_DIR}/#{youtube_id}.jpg"
    return false if File.exist?(path)

    if download_and_optimize("https://i.ytimg.com/vi/#{youtube_id}/maxresdefault.jpg", path, max_width: YOUTUBE_WIDTH) ||
       download_and_optimize("https://i.ytimg.com/vi/#{youtube_id}/hqdefault.jpg", path, max_width: YOUTUBE_WIDTH)
      warn "download-media: downloaded YouTube thumbnail #{youtube_id}"
      true
    else
      false
    end
  end

  def self.download_speakerdeck_for(data)
    speakerdeck_id = data["speakerdeck-id"].to_s.strip
    return false if speakerdeck_id.empty?

    path = "#{SPEAKERDECK_DIR}/#{speakerdeck_id}.jpg"
    return false if File.exist?(path)

    if download_and_optimize("https://files.speakerdeck.com/presentations/#{speakerdeck_id}/slide_0.jpg", path, max_width: YOUTUBE_WIDTH)
      warn "download-media: downloaded SpeakerDeck thumbnail #{speakerdeck_id}"
      true
    else
      false
    end
  end

  def self.download_link_image_for(file_path, data, body, raw_frontmatter, content)
    link_image = data["link_image"].to_s.strip
    return false if link_image.empty?
    return false unless link_image.start_with?("http://", "https://")

    target_dir = link_image_dir_for(file_path)
    return false unless target_dir

    slug = File.basename(file_path, ".md")
    local_path = "#{target_dir}/#{slug}.jpg"
    return false if File.exist?(local_path)
    return false unless download_and_optimize(link_image, local_path, max_width: LINK_IMAGE_WIDTH)

    data["link_image"] = "/#{local_path}"
    preserved_lines = preserved_frontmatter_lines(raw_frontmatter)
    preserved_lines.delete("link_image")
    rendered = render_frontmatter(data, body, preserved_lines: preserved_lines)
    if rendered != content
      File.write(file_path, rendered)
      warn "download-media: downloaded link image for #{file_path}"
    end
    true
  end

  def self.cleanup_orphaned_images
    cleaned = false
    { THOUGHTS_DIR => "_thoughts", INTERVIEWS_DIR => "_interviews" }.each do |dir, source_dir|
      Dir.glob("#{dir}/*.jpg").each do |image_path|
        next if File.exist?("#{source_dir}/#{File.basename(image_path, ".jpg")}.md")

        FileUtils.rm_f(image_path)
        cleaned = true
        warn "download-media: cleaned up orphaned image #{image_path}"
      end
    end
    cleaned
  end

  def self.download_and_optimize(url, output_path, max_width: LINK_IMAGE_WIDTH)
    uri = URI.parse(url)
    tmp_path = "#{output_path}.tmp"

    response = fetch_with_redirects(uri)
    return false unless response.is_a?(Net::HTTPSuccess)

    File.binwrite(tmp_path, response.body)

    if optimize_image(tmp_path, output_path, max_width: max_width)
      FileUtils.rm_f(tmp_path)
    else
      FileUtils.mv(tmp_path, output_path)
    end
    true
  rescue StandardError => e
    FileUtils.rm_f(tmp_path) if tmp_path
    warn "download-media: failed to download #{url}: #{e.message}"
    false
  end

  def self.fetch_with_redirects(uri, limit: 5)
    raise "too many redirects" if limit <= 0

    request = Net::HTTP::Get.new(uri.request_uri)
    request["User-Agent"] = USER_AGENT

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    case response
    when Net::HTTPRedirection
      location = response["location"].to_s
      return nil if location.empty?

      fetch_with_redirects(URI.join(uri.to_s, location), limit: limit - 1)
    else
      response
    end
  end

  def self.optimize_image(input_path, output_path, max_width: LINK_IMAGE_WIDTH)
    magick = find_imagemagick
    return false unless magick

    system(
      magick, input_path,
      "-resize", "#{max_width}>",
      "-strip",
      "-quality", JPEG_QUALITY.to_s,
      "-interlace", "Plane",
      output_path
    )
  end

  def self.find_imagemagick
    return @imagemagick if defined?(@imagemagick)

    @imagemagick = %w[magick convert].detect do |cmd|
      system("which", cmd, out: File::NULL, err: File::NULL)
    end
    warn "download-media: ImageMagick not found, skipping optimization" unless @imagemagick
    @imagemagick
  end

  def self.link_image_dir_for(path)
    text = path.to_s
    if text.start_with?("_thoughts/") || text.include?("/_thoughts/")
      THOUGHTS_DIR
    elsif text.start_with?("_interviews/") || text.include?("/_interviews/")
      INTERVIEWS_DIR
    end
  end

  def self.parse_frontmatter(content)
    match = content.match(FRONTMATTER_REGEXP)
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
        next if key == "link_image"

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
        rendered = YAML.dump({ key_string => value }).sub(/\A---\s*\n/, "").rstrip
        if key_string == "link"
          lines << "link: #{value.to_s.gsub(/\s+/, " ").strip}"
        elsif SINGLE_LINE_QUOTED_FIELDS.include?(key_string)
          lines << "#{key_string}: #{value.to_s.gsub(/\s+/, " ").strip.dump}"
        else
          lines.concat(rendered.lines(chomp: true))
        end
      end
    end
    lines << "---"
    +"#{lines.join("\n")}\n#{body}"
  end

  def self.each_content_file
    ensure_directories

    %w[_talks/*.md _interviews/*.md _thoughts/*.md].each do |glob|
      Dir.glob(glob).sort.each do |path|
        content = File.read(path)
        data, body, raw_frontmatter = parse_frontmatter(content)
        next unless data

        yield path, data, body, raw_frontmatter, content
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  DownloadMediaImages.run
end
