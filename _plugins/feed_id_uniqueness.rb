module Jekyll
  Jekyll::Hooks.register :site, :post_write do |site|
    errors = site.pages.filter_map do |page|
      layout = page.data["layout"].to_s
      next unless ["atom_feed", "podcast_feed"].include?(layout)

      path = page.destination(site.dest)
      next unless File.exist?(path)

      xml = File.read(path)

      case layout
      when "atom_feed"
        ids = xml.scan(/<entry>.*?<id>(.*?)<\/id>/m).flatten
        duplicate_ids = ids.tally.select { |_, count| count > 1 }.keys
        next if duplicate_ids.empty?

        "#{page.path || page.url} duplicate <id>: #{duplicate_ids.join(", ")}"
      when "podcast_feed"
        guids = xml.scan(/<guid\b[^>]*>(.*?)<\/guid>/m).flatten
        duplicate_guids = guids.map(&:strip).reject(&:empty?).tally.select { |_, count| count > 1 }.keys

        enclosures = xml.scan(/<enclosure\b[^>]*\burl="([^"]+)"/m).flatten
        duplicate_enclosures = enclosures.map(&:strip).reject(&:empty?).tally.select { |_, count| count > 1 }.keys

        next if duplicate_guids.empty? && duplicate_enclosures.empty?

        details = []
        details << "duplicate <guid>: #{duplicate_guids.join(", ")}" if duplicate_guids.any?
        details << "duplicate enclosure url: #{duplicate_enclosures.join(", ")}" if duplicate_enclosures.any?
        "#{page.path || page.url} #{details.join("; ")}"
      end
    end

    raise Jekyll::Errors::FatalException, "Duplicate feed entry ids: #{errors.join(", ")}" if errors.any?
  end
end
