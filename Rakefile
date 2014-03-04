require "rubygems"
require "rake"
require "rake/clean"

task :default => :jekyll

pygments = "_pygments.scss"
css = "style.css"
scss = FileList["*.scss"]
dizzy_base = "2007-02-27-making-dizzy-shine-with-ajax"
dizzy_adoc = "_posts/_#{dizzy_base}.asciidoc"
dizzy = "_posts/#{dizzy_base}.html"

file pygments do
  require "pygments"
  File.open(pygments, "w") {|f| f.write Pygments.css }
end

file css => FileList["*.scss"] do
  require "sass"
  File.open(css, "w") do |f|
    f.write Sass.compile_file("style.scss", :style => :compressed)
  end
end

file dizzy => dizzy_adoc do
  require "asciidoctor"
  options = {
    :attributes => {
      'skip-front-matter' => true,
    },
  }
  doc = Asciidoctor.load_file(dizzy_adoc, options)
  File.open(dizzy, "w") do |f|
    f.write "---\n#{doc.attributes["front-matter"]}\n---\n"
    f.write doc.render
  end
end

task :deps => [pygments, css, dizzy]

task :jekyll => :deps do
  sh "jekyll", "build"
end

CLEAN.include FileList[css, pygments, dizzy, "_site"]
