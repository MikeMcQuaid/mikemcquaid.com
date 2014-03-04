ENV['GUARD_NOTIFY'] = "false"

guard 'rake', :task => :deps do
  watch /.+\.scss$/
  watch %r{_posts/.+\.(asciidoc)$}
end

guard "jekyll-plus", :serve => true do
  watch /.*/
  ignore /^_site/
end

guard 'livereload' do
  watch %r{_site/.+\.(css|js|html|jpg|png)$}
end
