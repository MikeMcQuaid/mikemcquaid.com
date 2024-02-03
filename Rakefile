require "rake"
require "rake/clean"
require "etc"

task default: :test

task :jekyll do
  require "jekyll"
  Jekyll::Commands::Build.process({ strict_front_matter: true })
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
    ignore_status_codes: [0, 302, 303, 400, 429, 521],
    ignore_urls: [
      %r{^https://mikemcquaid.com/},
      %r{^https://twitter.com/},
      %r{^https://web\.archive\.org/web/},
      %r{^https://www\.linkedin\.com/},
      %r{^https://docs\.github\.com/en/},
      "https://github.com/pulls",
      "https://www.manning.com/books/git-in-practice?a_bid=5688bbf4&a_aid=MikeMcQuaid",
      "https://blogs.oracle.com/java/annoucing-javaone-2014-rock-stars-v2",
      "https://www.mailmunch.com/blog/sales-funnel/",
      "https://www.kickstarter.com/projects/homebrew/brew-test-bot",
      "https://www.tripadvisor.com",
      "https://podcasts.apple.com/sk/podcast/balancing-dads/id1483910799",
      "https://www.patreon.com/homebrew",
      "https://www.nytimes.com/2015/02/15/magazine/how-one-stupid-tweet-ruined-justine-saccos-life.html",
      "https://github.com/Homebrew/brew.sh/blob/bc5a12b3c94335a577629dbeffe225d88c000a75/_layouts/index.html#L4",
      "https://github.com/BrewTestBot",
      "https://www.numerama.com/tech/260469-comment-github-contribue-a-lessor-du-developpement-en-open-source.html",
      "https://github.com/MikeMcQuaid/GitInPractice#git-in-practice",
      "https://github.com/Homebrew/brew#donations",
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
