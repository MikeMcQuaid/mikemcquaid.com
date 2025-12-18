require "time"

# Ensure thoughts collection entries are processed even without YAML front matter
module ThoughtCollectionLoader
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    MAX_TITLE_LENGTH = 70

    def truncate_title(title)
      return title if title.length <= MAX_TITLE_LENGTH

      truncated = title[0...MAX_TITLE_LENGTH]
      truncated = truncated.sub(/\s+\S*\z/, "")
      "#{truncated.rstrip}..."
    end

    def title_from_content(content)
      text = content.to_s.strip
      return if text.empty?

      first_line = text.lines.first.to_s.strip
      first_line = first_line.gsub(/\[([^\]]+)\]\([^)]+\)/, '\1')
      first_sentence = first_line.split(/(?<=[.!?])\s/).first.to_s.strip
      candidate = first_sentence.empty? ? first_line : first_sentence
      return if candidate.empty?

      truncate_title(candidate)
    end

    def git_timestamp(path)
      git_output = `git log -1 --format=%cI -- "#{path}" 2>/dev/null`.strip
      Time.parse(git_output)
    end

    def generate(site)
      collection = site.collections["thoughts"]
      return unless collection

      thoughts_path = File.join(site.source, "_thoughts")
      Dir.glob(File.join(thoughts_path, "*.{md,markdown,html}")).each do |path|
        next unless File.file?(path)
        next if collection.docs.any? { |doc| doc.path == path }

        doc = Jekyll::Document.new(path, site: site, collection: collection)
        doc.read
        doc.data["layout"] = "thought"
        date = git_timestamp(path)
        doc.data["date"] = date
        doc.data["last_modified_at"] = date
        doc.data["permalink"] = "/thoughts/#{date.strftime("%Y%m%d%H%M%S")}/"
        doc.data["title"] = title_from_content(doc.content)
        collection.docs << doc
      end
    end
  end
end
