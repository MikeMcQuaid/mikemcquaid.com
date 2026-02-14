#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "open3"
require "pathname"
require "uri"

class TranscriptGenerator
  def initialize
    @talks_dir = Pathname("_talks")
    @audio_dir = Pathname("tmp/audio")
    @models_dir = Pathname("tmp/models")

    @audio_dir.mkpath
    @models_dir.mkpath
  end

  def run(paths: nil)
    Dir.chdir(File.expand_path("..", __dir__))

    entries = find_entries_with_sources(paths: paths).select { |entry| entry_needs_work?(entry) }
    return false if entries.empty?

    puts "transcripts: processing #{entries.length} entr#{entries.length == 1 ? "y" : "ies"}"

    changed = false
    entries.each do |entry|
      begin
        changed ||= process_entry(entry)
      rescue StandardError => e
        warn "transcripts: #{entry.fetch(:file)}: #{e.class}: #{e.message}"
      end
    end

    changed
  end

  private

  def find_entries_with_sources(paths: nil)
    candidate_files(paths: paths).sort.each_with_object([]) do |file, entries|
      entry = build_entry(file)
      entries << entry if entry
    end
  end

  def candidate_files(paths: nil)
    if paths.nil? || paths.empty?
      return @talks_dir.glob("*.md")
    end

    paths.map { |path| Pathname(path) }
         .select(&:exist?)
         .select { |path| transcript_collection_file?(path) }
  end

  def transcript_collection_file?(path)
    text = path.to_s
    text.start_with?("_talks/") || text.include?("/_talks/")
  end

  def build_entry(file)
    content = file.read
    youtube_id = frontmatter_value(content, "youtube-id")
    podcast_audio_url = frontmatter_value(content, "podcast_audio_url")
    transcript_id = frontmatter_value(content, "transcript-id")

    source = if !podcast_audio_url.empty?
      { type: :podcast, url: podcast_audio_url }
    elsif !youtube_id.empty?
      { type: :youtube, youtube_id: youtube_id }
    end
    return nil unless source

    transcript_id = sanitize_transcript_id(
      if !transcript_id.empty?
        transcript_id
      elsif !youtube_id.empty?
        youtube_id
      else
        file.basename(".md").to_s
      end
    )

    {
      file: file,
      source: source,
      youtube_id: youtube_id,
      transcript_id: transcript_id
    }
  end

  def entry_needs_work?(entry)
    transcript_path = data_transcript_path(entry)
    return true unless transcript_path.exist? && transcript_path.size.positive?

    frontmatter_needs_update?(entry)
  end

  def frontmatter_needs_update?(entry)
    content = entry.fetch(:file).read
    transcript_enabled = content.match?(/^transcript:\s*true\s*$/)
    return true unless transcript_enabled

    return false unless needs_transcript_id?(entry)

    current_id = frontmatter_value(content, "transcript-id")
    current_id != entry.fetch(:transcript_id)
  end

  def process_entry(entry)
    file = entry.fetch(:file)
    transcript_id = entry.fetch(:transcript_id)
    changed = false

    puts "transcripts: #{file.basename}: start"

    if data_transcript_path(entry).exist? && data_transcript_path(entry).size.positive?
      puts "transcripts: #{file.basename}: transcript already present"
      changed ||= ensure_transcript_frontmatter!(entry)
      return changed
    end

    transcript_cache_path = @audio_dir / "#{transcript_id}.yml"
    if transcript_cache_path.exist? && transcript_cache_path.size.positive?
      puts "transcripts: #{file.basename}: using cached transcript"
      copy_transcript_to_data_dir(transcript_cache_path, transcript_id)
      changed = true
      changed ||= ensure_transcript_frontmatter!(entry)
      return changed
    end

    puts "transcripts: #{file.basename}: generating transcript"
    return changed unless generate_transcript(entry)

    if transcript_cache_path.exist? && transcript_cache_path.size.positive?
      copy_transcript_to_data_dir(transcript_cache_path, transcript_id)
      changed = true
      changed ||= ensure_transcript_frontmatter!(entry)
      puts "transcripts: #{file.basename}: transcript written"
    else
      warn "transcripts: #{file.basename}: transcript generation finished but no output file"
    end

    changed
  end

  def generate_transcript(entry)
    transcript_id = entry.fetch(:transcript_id)
    source = entry.fetch(:source)
    audio_path = source_audio_path(entry)
    transcript_path = @audio_dir / "#{transcript_id}.yml"

    if audio_path.exist?
      puts "transcripts: #{entry.fetch(:file).basename}: using cached audio"
    elsif source.fetch(:type) == :podcast
      puts "transcripts: #{entry.fetch(:file).basename}: downloading podcast audio"
      return false unless download_podcast_audio(source.fetch(:url), audio_path)
    else
      puts "transcripts: #{entry.fetch(:file).basename}: downloading YouTube audio"
      return false unless download_youtube_audio(source.fetch(:youtube_id), audio_path)
    end

    run_whisper(audio_path, transcript_path, entry.fetch(:file).basename.to_s)
  end

  def data_transcript_path(entry)
    Pathname("_data/transcripts") / "#{entry.fetch(:transcript_id)}.yml"
  end

  def source_audio_path(entry)
    source = entry.fetch(:source)
    transcript_id = entry.fetch(:transcript_id)

    if source.fetch(:type) == :podcast
      @audio_dir / "#{transcript_id}_podcast#{audio_extension_for_url(source.fetch(:url))}"
    else
      @audio_dir / "#{transcript_id}.wav"
    end
  end

  def audio_extension_for_url(url)
    extension = File.extname(URI.parse(url).path.to_s).downcase
    return ".mp3" unless extension.match?(/\A\.[a-z0-9]{1,8}\z/)

    extension
  rescue URI::InvalidURIError
    ".mp3"
  end

  def download_youtube_audio(youtube_id, output_path)
    video_url = "https://www.youtube.com/watch?v=#{youtube_id}"
    cmd = [
      "yt-dlp",
      "--format", "bestaudio",
      "--extract-audio",
      "--audio-format", "wav",
      "--audio-quality", "0",
      "--output", output_path.to_s,
      "--no-playlist",
      video_url
    ]

    _, stderr, status = Open3.capture3(*cmd)
    return true if status.success?

    warn "transcripts: YouTube download failed: #{stderr}"
    false
  end

  def download_podcast_audio(url, output_path)
    cmd = [
      "curl",
      "-L",
      "--fail",
      "--silent",
      "--show-error",
      "--output", output_path.to_s,
      url
    ]

    _, stderr, status = Open3.capture3(*cmd)
    return true if status.success? && output_path.exist? && output_path.size.positive?

    warn "transcripts: podcast download failed: #{stderr}"
    false
  end

  def run_whisper(audio_path, output_path, label)
    processed_audio_path = @audio_dir / "#{audio_path.basename(".*")}_processed.wav"
    srt_cache_path = @audio_dir / "#{audio_path.basename(".*")}.srt"

    unless processed_audio_path.exist?
      ffmpeg_cmd = [
        "ffmpeg",
        "-i", audio_path.to_s,
        "-ar", "16000",
        "-ac", "1",
        "-y",
        processed_audio_path.to_s
      ]

      puts "transcripts: #{label}: converting audio"
      _, stderr, status = Open3.capture3(*ffmpeg_cmd)
      unless status.success?
        warn "transcripts: #{label}: ffmpeg conversion failed: #{stderr}"
        return false
      end
    end

    if srt_cache_path.exist?
      puts "transcripts: #{label}: using cached SRT"
      convert_srt_to_yaml(srt_cache_path, output_path)
      return true
    end

    model_path = download_whisper_model
    return false unless model_path

    whisper_cmd = [
      "whisper-cli",
      "--model", model_path.to_s,
      "--output-srt",
      "--language", "en",
      "--output-file", srt_cache_path.sub_ext("").to_s,
      processed_audio_path.to_s
    ]

    metal_path = "#{`brew --prefix whisper-cpp`.strip}/share/whisper-cpp"
    env = ENV.to_h.merge("GGML_METAL_PATH_RESOURCES" => metal_path)

    puts "transcripts: #{label}: running whisper"
    _, stderr, status = Open3.capture3(env, *whisper_cmd)
    unless status.success?
      warn "transcripts: #{label}: whisper failed: #{stderr}"
      return false
    end

    unless srt_cache_path.exist?
      warn "transcripts: #{label}: whisper succeeded but no SRT output"
      return false
    end

    convert_srt_to_yaml(srt_cache_path, output_path)
    true
  end

  def download_whisper_model
    model_name = "ggml-large-v3-turbo.bin"
    model_path = @models_dir / model_name
    return model_path if model_path.exist?

    puts "transcripts: downloading whisper model"
    cmd = [
      "curl",
      "-L",
      "--fail",
      "--silent",
      "--show-error",
      "--output", model_path.to_s,
      "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/#{model_name}"
    ]
    _, stderr, status = Open3.capture3(*cmd)

    if status.success? && model_path.exist? && model_path.size > 1_000_000
      puts "transcripts: whisper model downloaded"
      return model_path
    end

    warn "transcripts: whisper model download failed: #{stderr}"
    model_path.delete if model_path.exist?
    nil
  end

  def convert_srt_to_yaml(srt_path, yaml_path)
    transcript_data = {}
    blocks = srt_path.read.strip.split(/\n\s*\n/)

    blocks.each do |block|
      lines = block.strip.split("\n")
      next if lines.length < 3

      timestamp_match = lines[1].match(/(\d{2}):(\d{2}):(\d{2})[,.](\d{3})\s*-->/)
      next unless timestamp_match

      hours, minutes, seconds, = timestamp_match.captures.map(&:to_i)
      start_seconds = (hours * 3600) + (minutes * 60) + seconds
      text = lines[2..].join(" ").strip
      next if text.empty?

      transcript_data[start_seconds] = text
    end

    yaml_path.write(transcript_data.to_yaml)
  end

  def copy_transcript_to_data_dir(transcript_path, transcript_id)
    data_dir = Pathname("_data/transcripts")
    data_dir.mkpath
    FileUtils.cp(transcript_path, data_dir / "#{transcript_id}.yml")
  end

  def ensure_transcript_frontmatter!(entry)
    file = entry.fetch(:file)
    content = file.read
    match = content.match(/\A---\s*\n(.*?)\n---\s*\n/m)
    return false unless match

    lines = match[1].lines(chomp: true)
    body = content[match.end(0)..] || ""
    changed = false

    unless lines.any? { |line| line.match?(/^transcript:\s*true\s*$/) }
      lines.insert(insert_after(lines, %w[youtube-id podcast_audio_url link]), "transcript: true")
      changed = true
      puts "transcripts: #{file.basename}: added transcript flag"
    end

    if needs_transcript_id?(entry)
      transcript_id = entry.fetch(:transcript_id)
      idx = lines.index { |line| line.match?(/^transcript-id:\s*\S+/) }
      if idx
        current = normalize_frontmatter_scalar(lines[idx].sub(/^transcript-id:\s*/, ""))
        if current != transcript_id
          lines[idx] = "transcript-id: #{transcript_id}"
          changed = true
          puts "transcripts: #{file.basename}: updated transcript-id"
        end
      else
        lines.insert(insert_after(lines, %w[transcript youtube-id podcast_audio_url link]), "transcript-id: #{transcript_id}")
        changed = true
        puts "transcripts: #{file.basename}: added transcript-id"
      end
    end

    return false unless changed

    file.write("---\n#{lines.join("\n")}\n---\n#{body}")
    true
  end

  def needs_transcript_id?(entry)
    youtube_id = entry.fetch(:youtube_id)
    youtube_id.empty? || entry.fetch(:transcript_id) != youtube_id
  end

  def insert_after(lines, keys)
    keys.each do |key|
      index = lines.index { |line| line.match?(/^#{Regexp.escape(key)}:\s*/) }
      return index + 1 if index
    end
    lines.length
  end

  def frontmatter_value(content, key)
    match = content.match(/^#{Regexp.escape(key)}:\s*(.+)$/)
    return "" unless match

    normalize_frontmatter_scalar(match[1])
  end

  def normalize_frontmatter_scalar(value)
    text = value.to_s.strip
    return "" if text.empty?

    if (text.start_with?('"') && text.end_with?('"')) || (text.start_with?("'") && text.end_with?("'"))
      text = text[1..-2]
    end
    text.strip
  end

  def sanitize_transcript_id(value)
    value.to_s.gsub(/[^A-Za-z0-9._-]/, "-")
  end
end

if __FILE__ == $PROGRAM_NAME
  paths = ARGV.empty? ? nil : ARGV
  TranscriptGenerator.new.run(paths: paths)
end
