require "digest"

module Jekyll
  module CacheBustFilter
    CACHE = {}

    def cache_bust(asset_path)
      site = @context.registers[:site]
      relative_path = asset_path.to_s.sub(%r{\A/}, "")
      source_path = File.join(site.source, relative_path)

      cached = CACHE[source_path]
      mtime = File.mtime(source_path).to_i
      return cached[:digest] if cached && cached[:mtime] == mtime

      digest = Digest::SHA256.file(source_path).hexdigest[0, 10]
      CACHE[source_path] = { mtime:, digest: }
      digest
    end
  end
end

Liquid::Template.register_filter(Jekyll::CacheBustFilter)
