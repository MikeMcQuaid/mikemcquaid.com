module Jekyll
  Jekyll::Hooks.register :site, :post_write do |site|
    errors = site.pages.filter_map do |page|
      next unless page.data["layout"] == "atom_feed"

      path = page.destination(site.dest)
      next unless File.exist?(path)

      ids = File.read(path).scan(/<entry>.*?<id>(.*?)<\/id>/m).flatten
      dupes = ids.tally.select { |_, count| count > 1 }.keys
      next if dupes.empty?

      "#{page.path || page.url} (#{dupes.join(", ")})"
    end

    raise Jekyll::Errors::FatalException, "Duplicate feed entry ids: #{errors.join(", ")}" if errors.any?
  end
end
