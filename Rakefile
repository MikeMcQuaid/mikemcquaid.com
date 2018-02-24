require "rubygems"
require "rake"
require "rake/clean"

task default: :jekyll

dizzy_base = "2007-02-27-making-dizzy-shine-with-ajax"
dizzy_adoc = "_posts/_#{dizzy_base}.asciidoc"
dizzy = "_posts/#{dizzy_base}.html"

file dizzy => dizzy_adoc do
  require "asciidoctor"
  options = { attributes: { "skip-front-matter" => true } }
  doc = Asciidoctor.load_file(dizzy_adoc, options)
  File.open(dizzy, "w") do |f|
    f.write <<~EOS
      ---
      #{doc.attributes["front-matter"]}
      ---
EOS
    f.puts doc.render
  end
end

task deps: dizzy

task jekyll: :deps do
  sh "jekyll", "build"
end

CLEAN.include FileList[dizzy, "_site"]

desc "Run html proofer to validate the HTML output."
task test: :jekyll do
  require "html-proofer"
  HTMLProofer.check_directory(
    "./_site",
    url_ignore: %w[
      https://www.facebook.com/mkmcqd
    ],
    parallel: { in_processes: 4 },
    favicon: true,
    http_status_ignore: [0, 503],
    assume_extension: true,
    check_external_hash: true,
    check_favicon: true,
    check_opengraph: true,
    check_html: true
  ).run
end
