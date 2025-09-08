#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "fileutils"
require "pathname"
require "yaml"

# Generate Jekyll-friendly transcripts from YouTube videos
class TranscriptGenerator
  def initialize
    @talks_dir = Pathname("_talks")
    @audio_dir = Pathname("tmp/audio")
    @models_dir = Pathname("tmp/models")
    @processed_file = Pathname("tmp/processed_transcripts.txt")

    @audio_dir.mkpath
    @models_dir.mkpath
    @processed = load_processed_list
  end

  def run
    Dir.chdir(File.expand_path("..", __dir__))

    puts "Starting transcript generation for talks with YouTube IDs..."

    talks_with_youtube = find_talks_with_youtube
    puts "Found #{talks_with_youtube.length} talks with YouTube IDs"

    talks_with_youtube.each do |talk_file|
      process_talk(talk_file)
    end

    save_processed_list
    puts
    puts "Transcript generation complete!"
  end

  private

  def find_talks_with_youtube
    @talks_dir.glob("*.md").select do |file|
      file.read.match?(/youtube-id:\s*\S+/)
    end
  end

  def process_talk(talk_file)
    puts
    puts "Processing: #{talk_file.basename}"

    content = talk_file.read
    youtube_id = content.match(/youtube-id:\s*(\S+)/)&.[](1)&.strip

    unless youtube_id
      puts "  No YouTube ID found, skipping"
      return
    end

    puts "  YouTube ID: #{youtube_id}"

    # Check if transcript already exists in the markdown file
    if content.include?("<details>") && content.include?("Transcript")
      puts "  Transcript already exists in markdown, skipping"
      @processed << talk_file
      return
    end

    puts "  No transcript in markdown, checking cache..."

    transcript_path = @audio_dir / "#{youtube_id}.yml"
    if transcript_path.exist?
      puts "  Using cached transcript file"
      if transcript_path.size.positive?
        copy_transcript_to_data_dir(transcript_path, youtube_id)
        add_transcript_flag_to_talk(talk_file)
        puts "  ✓ Transcript copied to _data/transcripts from cache"
        @processed << talk_file
        return
      end
    end

    if @processed.include?(talk_file)
      puts "  Already processed this file but no transcript found, regenerating..."
    else
      puts "  No cached transcript, generating new one..."
    end

    begin
      if generate_transcript(youtube_id)
        transcript_path = @audio_dir / "#{youtube_id}.yml"
        if transcript_path.exist? && transcript_path.size.positive?
          copy_transcript_to_data_dir(transcript_path, youtube_id)
          add_transcript_flag_to_talk(talk_file)
          puts "  ✓ Transcript generated and copied to _data/transcripts"
        else
          puts "  ✗ Failed to generate transcript"
        end
      else
        puts "  ✗ Failed to generate transcript"
        puts "  Continuing with next talk..."
      end
    rescue => e
      puts "  ✗ Error processing talk: #{e.message}"
      puts "  Backtrace:"
      puts e.backtrace.map { |line| "    #{line}" }.join("\n")
    end

    @processed << talk_file
  end

  def generate_transcript(youtube_id)
    video_url = "https://www.youtube.com/watch?v=#{youtube_id}"
    audio_path = @audio_dir / "#{youtube_id}.wav"
    transcript_path = @audio_dir / "#{youtube_id}.yml"

    if audio_path.exist?
      puts "  Using cached audio file"
    else
      puts "  Downloading audio..."
      return false unless download_audio(video_url, audio_path)
    end

    puts "  Generating transcript with Whisper..."
    return false unless run_whisper(audio_path, transcript_path)

    transcript_path.exist? && transcript_path.size.positive?
  end

  def download_audio(url, output_path)
    cmd = [
      "yt-dlp",
      "--format", "bestaudio", # Download only audio
      "--extract-audio",
      "--audio-format", "wav",
      "--audio-quality", "0", # Best quality
      "--output", output_path.to_s,
      "--no-playlist",
      url
    ]

    _, stderr, status = Open3.capture3(*cmd)

    if status.success?
      true
    else
      puts "    Download failed: #{stderr}"
      false
    end
  end

  def run_whisper(audio_path, output_path)
    processed_audio_path = @audio_dir / "#{audio_path.basename(".*")}_processed.wav"
    srt_cache_path = @audio_dir / "#{audio_path.basename(".*")}.srt"

    # Step 1: Convert audio to 16kHz mono WAV using ffmpeg (only if not cached)
    if processed_audio_path.exist?
      puts "    Using cached 16kHz mono audio file"
    else
      ffmpeg_cmd = [
        "ffmpeg",
        "-i", audio_path.to_s,
        "-ar", "16000",
        "-ac", "1",
        "-y", # Overwrite output file
        processed_audio_path.to_s
      ]

      puts "    Converting audio to 16kHz mono..."
      _, stderr, status = Open3.capture3(*ffmpeg_cmd)

      unless status.success?
        puts "    FFmpeg conversion failed: #{stderr}"
        return false
      end
    end

    # Step 2: Check for cached SRT file first
    if srt_cache_path.exist?
      puts "    Using cached SRT file"
      convert_srt_to_yaml(srt_cache_path, output_path)
      return true
    end

    # Step 3: Run whisper-cli directly
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

    # Set environment variable for Metal optimization
    metal_path = "#{`brew --prefix whisper-cpp`.strip}/share/whisper-cpp"
    env = ENV.to_h.merge("GGML_METAL_PATH_RESOURCES" => metal_path)

    puts "    Running Whisper transcription..."
    _, stderr, status = Open3.capture3(env, *whisper_cmd)

    if status.success?
      # SRT file is now output directly to cache, convert to YAML
      if srt_cache_path.exist?
        convert_srt_to_yaml(srt_cache_path, output_path)
        true
      else
        puts "    Whisper failed: No SRT output generated"
        false
      end
    else
      puts "    Whisper failed: #{stderr}"
      false
    end
  end

  def download_whisper_model
    # Use large-v3-turbo model
    model_name = "ggml-large-v3-turbo.bin"
    model_path = @models_dir / model_name

    if model_path.exist?
      puts "  Using cached Whisper model: #{model_path}"
      return model_path
    end

    puts "  Downloading Whisper model..."
    # Try multiple URLs for the model
    urls = [
      "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/#{model_name}",
    ]

    success = false
    urls.each do |url|
      puts "    Trying: #{url}"
      success = system("curl -L -o '#{model_path.to_s}' '#{url}'")
      if success && model_path.size > 1000000 # Check if file is large enough
        puts "    Model downloaded successfully"
        break
      else
        puts "    Download failed or file too small"
        model_path.delete if model_path.exist?
      end
    end

    unless success
      puts "    Failed to download model from all sources"
      return
    end

    model_path
  end

  def convert_srt_to_txt(srt_path, txt_path)
    content = srt_path.read

    # Remove SRT timestamps and formatting, keep only text
    text = content.gsub(/^\d+\s*$/, "") # Remove sequence numbers
                  .gsub(/^\d{2}:\d{2}:\d{2},\d{3}\s*-->\s*\d{2}:\d{2}:\d{2},\d{3}\s*$/, "") # Remove timestamps
                  .gsub(/^\s*$/, "") # Remove empty lines
                  .strip

    txt_path.write(text)
  end

  def convert_srt_to_yaml(srt_path, yaml_path)
    content = srt_path.read
    transcript_data = {}

    # Parse SRT format
    blocks = content.strip.split(/\n\s*\n/)

    blocks.each do |block|
      lines = block.strip.split("\n")
      next if lines.length < 3

      # Extract timestamp from second line
      timestamp_match = lines[1].match(/(\d{2}):(\d{2}):(\d{2})[,.](\d{3})\s*-->/)
      next unless timestamp_match

      hours, minutes, seconds, = timestamp_match.captures.map(&:to_i)
      start_seconds = (hours * 3600) + (minutes * 60) + seconds

      # Extract text from remaining lines
      text = lines[2..].join(" ").strip
      next if text.empty?

      transcript_data[start_seconds] = text
    end

    # Write YAML file
    yaml_path.write(transcript_data.to_yaml)
  end

  def copy_transcript_to_data_dir(transcript_path, youtube_id)
    data_dir = Pathname("_data/transcripts")
    data_dir.mkpath

    # Use the YouTube ID as the filename
    target_path = data_dir / "#{youtube_id}.yml"
    FileUtils.cp(transcript_path, target_path)
  end

  def add_transcript_flag_to_talk(talk_file)
    content = talk_file.read

    # Check if transcript flag already exists
    return if content.match?(/^transcript:\s*true/m)

    # Add transcript: true after youtube-id
    return unless content.match?(/^youtube-id:\s*\S+/m)

    content = content.gsub(/^(youtube-id:\s*\S+)$/m, "\\1\ntranscript: true")
    talk_file.write(content)
    puts "  ✓ Added transcript: true to talk file"
  end

  def load_processed_list
    if @processed_file.exist?
      @processed_file.readlines.map(&:strip)
    else
      []
    end
  end

  def save_processed_list
    @processed_file.write(@processed.join("\n"))
  end
end

if __FILE__ == $PROGRAM_NAME
  generator = TranscriptGenerator.new
  generator.run
end
