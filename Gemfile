source "https://rubygems.org"

ruby file: ".ruby-version"

gem "jekyll"

# needed for Ruby >=3.0
gem "webrick"

# needed for Ruby >=3.4
gem "base64"
gem "csv"

# stops message being printed every startup
gem "faraday-retry"

group :jekyll_plugins do
  gem "jekyll-asciidoc"
  gem "jekyll-feed"
  gem "jekyll-optional-front-matter"
  gem "jekyll-redirect-from"
  gem "jekyll-relative-links"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
  gem "jekyll-titles-from-headings"
end

group :development do
  gem "rake"
end

group :test do
  gem "html-proofer"
end
