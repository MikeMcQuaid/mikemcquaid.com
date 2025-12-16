require "time"

# Ensure thoughts collection entries are processed even without YAML front matter
module ThoughtCollectionLoader
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def git_timestamp(path)
      git_output = `git log -1 --format=%cI -- "#{path}" 2>/dev/null`.strip
      return File.mtime(path) if git_output.empty?

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
        doc.data["layout"] ||= "thought"
        doc.data["date"] ||= git_timestamp(path)
        doc.data["last_modified_at"] ||= doc.data["date"]
        doc.data["permalink"] ||= "/thoughts/#{doc.basename_without_ext}/"
        doc.data["title"] ||= doc.basename_without_ext.tr("-", " ").strip
        collection.docs << doc
      end
    end
  end
end
