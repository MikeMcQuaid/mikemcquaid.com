#!/usr/bin/env ruby
# frozen_string_literal: true

require "time"
require "open3"

require_relative "content_link_metadata"
require_relative "download_media_images"
require_relative "generate_transcripts"
require_relative "podcast_feed_importer"

class EnrichMetadataCLI
  def self.run(args)
    new(args).run
  end

  def initialize(args)
    @args = args.dup
  end

  def run
    action = @args.first

    case action
    when "add-githooks"
      add_githooks
    when "remove-githooks"
      remove_githooks
    when "status-githooks"
      status_githooks
    when "update"
      @args.shift
      update(@args)
    when "link-metadata"
      @args.shift
      link_metadata(@args)
    when "download-media"
      @args.shift
      download_media(@args)
    when "new"
      create_new_thought
    when "transcripts"
      run_transcripts
    when "podcast-feeds"
      @args.shift
      run_podcast_feeds(@args)
    when "run"
      @args.shift
      run_all(@args)
    when "-h", "--help", "help"
      usage
    else
      run_all(@args)
    end
  end

  private

  def usage
    puts <<~USAGE
      Usage: bin/enrich-metadata <command> [files]

      Commands:
        run              Run all enrichment (default)
        update <files>   Enrich metadata and download media for specific files
        link-metadata    Enrich link metadata and generate transcripts
        download-media   Download and optimise all media images
        new              Create a new thought
        transcripts      Generate transcripts
        podcast-feeds    Import external podcast feeds
        add-githooks     Enable pre-commit hooks
        remove-githooks  Disable pre-commit hooks
        status-githooks  Show current hooks status
    USAGE
  end

  def add_githooks
    system!("git", "config", "core.hooksPath", ".githooks")
    warn "enrich-metadata: git hooks enabled (.githooks)"
  end

  def remove_githooks
    system("git", "config", "--unset", "core.hooksPath")
  end

  def status_githooks
    hooks_path = capture("git", "config", "--get", "core.hooksPath").strip
    if hooks_path == ".githooks"
      puts "enabled (.githooks)"
    elsif hooks_path.empty?
      puts "disabled (default)"
    else
      puts "custom (#{hooks_path})"
    end
  end

  def ensure_githooks
    hooks_path = capture("git", "config", "--get", "core.hooksPath").strip
    return if hooks_path == ".githooks"

    system("git", "config", "core.hooksPath", ".githooks")
    warn "enrich-metadata: enabled git hooks (.githooks)"
  end

  def update(files)
    if files.empty?
      warn "no files provided!"
      exit 1
    end

    ContentLinkMetadata.run(files)
    DownloadMediaImages.run_for_paths(files)
    TranscriptGenerator.new.run(paths: files)
  end

  def link_metadata(files)
    ContentLinkMetadata.run(files)
    TranscriptGenerator.new.run(paths: files)
  end

  def download_media(args)
    if args.empty?
      DownloadMediaImages.run
    else
      DownloadMediaImages.run_for_paths(args)
    end
  end

  def run_transcripts
    TranscriptGenerator.new.run
  end

  def run_podcast_feeds(args)
    args.each { |arg| unknown_option!(arg) }

    PodcastFeedImporter.new.run
  end

  def run_all(args)
    ensure_githooks

    paths = []

    args.each do |arg|
      unknown_option!(arg) if arg.start_with?("--")
      paths << arg
    end

    ContentLinkMetadata.run(paths)
    if paths.empty?
      DownloadMediaImages.run
    else
      DownloadMediaImages.run_for_paths(paths)
    end
    TranscriptGenerator.new.run(paths: paths.empty? ? nil : paths)
    PodcastFeedImporter.new.run
  end

  def create_new_thought
    timestamp = Time.now.strftime("%Y%m%d%H%M")
    file = "_thoughts/#{timestamp}.md"
    if File.exist?(file)
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      file = "_thoughts/#{timestamp}.md"
    end

    link = ""
    thought_text = ""
    if $stdin.tty?
      puts "Thought (end with Ctrl-D):"
      thought_text = File.open("/dev/tty", &:read)
      File.open("/dev/tty") do |tty|
        print "Optional link (leave blank for none): "
        $stdout.flush
        link = tty.gets.to_s.chomp
      end
    else
      thought_text = $stdin.read
    end

    if thought_text.strip.empty?
      warn "Aborted: no thought content provided."
      exit 1
    end

    if link.empty?
      File.write(file, "#{thought_text}\n")
    else
      File.write(file, "---\nlink: #{link}\n---\n#{thought_text}\n")
    end

    system!("git", "add", file)
    update([file])
    system!("git", "add", file, "images/media")
    system!("git", "commit", "--no-verify", "-m", "Add thought #{timestamp}")

    warn "enrich-metadata: running Jekyll build to check for errors..."
    unless system("bundle", "exec", "jekyll", "build", "--quiet")
      warn "enrich-metadata: Jekyll build failed! Check the output above."
    end

    return unless $stdin.tty?

    editor = ENV.fetch("EDITOR", "code")
    system(editor, file)
  end

  def capture(*cmd)
    output, status = Open3.capture2e(*cmd)
    return "" unless status.success?

    output
  end

  def system!(*cmd)
    return if system(*cmd)

    warn "Failed: #{cmd.join(' ')}"
    exit 1
  end

  def unknown_option!(option)
    warn "Unknown option: #{option}"
    usage
    exit 1
  end
end

if __FILE__ == $PROGRAM_NAME
  EnrichMetadataCLI.run(ARGV)
end
