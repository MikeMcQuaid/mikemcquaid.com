brew "ruby", version_file: ".ruby-version"
brew "xz"

ENV["HOMEBREW_INSIDE_BUNDLE"] = "1"

if ENV["HOMEBREW_GENERATE_TRANSCRIPTS"]
  brew "ffmpeg"
  brew "yt-dlp"
  brew "whisper-cpp"
end
