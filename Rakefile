require "rake"
require "rake/clean"
require "etc"

task default: :test

dizzy_base = "2007-02-27-making-dizzy-shine-with-ajax"
dizzy_adoc = "_posts/_#{dizzy_base}.asciidoc"
dizzy = "_posts/#{dizzy_base}.html"
CLEAN.include FileList[dizzy, "_site"]

file dizzy => dizzy_adoc do
  require "asciidoctor"
  options = { attributes: { "skip-front-matter" => true } }
  doc = Asciidoctor.load_file(dizzy_adoc, options)
  File.open(dizzy, "w") do |f|
    f.write <<~YAML
      ---
      #{doc.attributes["front-matter"]}
      ---
    YAML
    f.puts doc.render
  end
end

task deps: dizzy

task jekyll: :deps do
  require "jekyll"
  Jekyll::Commands::Build.process({ future: true })
end

desc "Run html proofer to validate the HTML output."
task test: :jekyll do
  require "html-proofer"

  HTMLProofer.check_directory(
    "./_site",
    # TODO: enable
    allow_hash_href: false,
    allow_missing_href: false,
    cache: {
      timeframe: {
        external: "1h",
      }
    },
    check_external_hash: true,
    check_favicon: true,
    check_opengraph: true,
    check_html: true,
    check_img_http: true,
    # TODO: enable
    enforce_https: false,
    # TODO: disable
    ignore_empty_alt: true,
    ignore_files: [
      %r{/making-dizzy-shine-with-ajax/},
    ],
    ignore_status_codes: [0, 302, 303, 429, 521],
    ignore_urls: [
      %r{^https://web\.archive\.org/web/},
      %r{^https://www\.linkedin\.com/},
      %r{^https://docs\.github\.com/en/},
      "https://github.com/pulls",
      "https://twitter.com/MikeMcQuaid",
      "https://www.manning.com/books/git-in-practice?a_bid=5688bbf4&a_aid=MikeMcQuaid",
      "https://blogs.oracle.com/java/annoucing-javaone-2014-rock-stars-v2",
      "https://www.mailmunch.com/blog/sales-funnel/",
      "https://www.kickstarter.com/projects/homebrew/brew-test-bot",
      "https://www.tripadvisor.com",
      "https://podcasts.apple.com/sk/podcast/balancing-dads/id1483910799",
      "https://www.patreon.com/homebrew",
    ],
    parallel: { in_processes: Etc.nprocessors },
    validation: {
      report_eof_tags: true,
      report_invalid_tags: true,
      report_mismatched_tags: true,
      report_missing_doctype: true,
      report_missing_names: true,
      report_script_embeds: true,
    }
  ).run
end
