require "time"
require_relative "../lib/thought_link_metadata"

module Jekyll
  class PosseLimits < Generator
    safe true
    priority :low

    # Max length of a thought title
    THOUGHT_TITLE_MAX_LENGTH = 70

    # X/Twitter has the shortest character limit of all the platforms
    # we care about.
    X_TWITTER_MAX_LENGTH = 280

    # Only show 25 items in the feed
    MAX_FEED_ITEMS = 25

    def generate(site)
      @config = site.config
      thoughts = load_thoughts(site)
      apply_thought_link_posse(site, thoughts)
      validate_posse_collections(site, thoughts)
    end

    private

    def validate_posse_collections(site, thoughts)
      articles = feed_docs(site.posts.docs)
      talks = feed_docs(site.collections.fetch("talks").docs)
      interviews = feed_docs(site.collections.fetch("interviews").docs)
      link_thoughts, other_thoughts = feed_docs(thoughts).partition do |doc|
        doc.data["link"].to_s.strip != ""
      end

      errors = []

      validate_collection(articles, limit_with_url, errors, method(:article_text))
      validate_collection(talks, limit_with_url, errors, method(:talk_text))
      validate_collection(interviews, limit_with_url, errors, method(:interview_text))
      validate_collection(link_thoughts, limit_with_url, errors, method(:thought_text))
      validate_collection(other_thoughts, limit_without_url, errors, method(:thought_text))
      return if errors.empty?

      raise Jekyll::Errors::FatalException, "POSSE text too long: #{errors.join(", ")}"
    end

    def load_thoughts(site)
      collection = site.collections.fetch("thoughts")

      thoughts_path = File.join(site.source, "_thoughts")
      Dir.glob(File.join(thoughts_path, "*.md")).each do |path|
        next if collection.docs.any? { |doc| doc.path == path }

        collection.docs << Jekyll::Document.new(path, site:, collection:)
      end

      collection.docs.each do |doc|
        path = doc.path
        git_log_dates_output = `git log --format=%cI --reverse -- "#{path}" 2>/dev/null`
        git_creation_date_output = git_log_dates_output.lines.first.to_s.strip
        raise Jekyll::Errors::FatalException, "Failed to get git date for #{path}!" if git_creation_date_output.empty?

        git_date = Time.parse(git_creation_date_output)

        doc.read
        apply_thought_link_metadata(doc)
        doc.data["title"] = thought_title_from_content(doc.content)
        doc.data["description"] = doc.content.to_s.strip
        doc.data["layout"] = "thought"
        doc.data["date"] = doc.data["last_modified_at"] = git_date
        doc.data["permalink"] = "/thoughts/#{git_date.strftime("%Y%m%d%H%M%S")}/"
      end

      collection.docs
    end

    def apply_thought_link_posse(site, docs)
      feed_page = feed_page_for(site, "thoughts")
      base_posse_post = feed_page.data.fetch("posse_post")
      linked_posse_post = feed_page.data.fetch("posse_post_with_link")
      docs.each do |doc|
        next if doc.data["posse_post"]

        link = doc.data["link"].to_s.strip
        posse_post = if link.empty?
          base_posse_post
        else
          linked_posse_post
        end.dup
        if link != ""
          link_title = doc.data["link_title"].to_s.strip
          link_description = doc.data["link_description"].to_s.strip
          if link_title.empty? || link_description.empty?
            raise Jekyll::Errors::FatalException,
                  "Thought link metadata missing: #{doc.relative_path}"
          end
          posse_post["title"] = link_title
          posse_post["summary"] = link_description
        end
        doc.data["posse_post"] = posse_post
      end
    end

    def validate_collection(docs, limit, errors, text_getter)
      safety_margin = 10

      docs.each do |doc|
        max = limit.fetch(:max) -
              limit.fetch(:reserved_for_url) -
              limit.fetch(:spacer) -
              safety_margin
        raise Jekyll::Errors::FatalException, "POSSE limit too low (#{max} < 1)" if max < 1

        text = text_getter.call(doc)
                          .to_s
                          .gsub(/\s+/, " ")
                          .strip
        return if text.length <= max

        errors << "#{doc.relative_path} (#{text.length} > #{max})"
      end
    end

    def description_summary_content_text(doc)
      doc.data["description"] || doc.data["summary"] || doc.content
    end

    def article_text(doc)
      description_summary_content_text(doc)
    end

    def talk_text(doc)
      format_string = format_string_for("talks", doc.site)
      title = doc.data.fetch("title").to_s
      summary = description_summary_content_text(doc)
      render_format(format_string, title:, summary:)
    end

    def interview_text(doc)
      format_string = format_string_for("interviews", doc.site)
      title = doc.data.fetch("title").to_s
      content = interview_content_text(doc)
      render_format(format_string, title:, content:)
    end

    def thought_text(doc)
      doc.content
    end

    def interview_content_text(doc)
      publication = doc.data.fetch("publication").to_s
      interviewed_by = "Interviewed by #{publication}."
      body = doc.content.to_s.strip
      return interviewed_by if body.empty?

      "#{interviewed_by}\n\n#{body}"
    end

    def format_string_for(collection, site)
      feed_page_for(site, collection).data.fetch("posse_post").fetch("format_string")
    end

    def render_format(format_string, variables)
      Liquid::Template.parse(format_string)
                      .render(variables.transform_keys(&:to_s))
    end

    def feed_docs(docs)
      docs.sort_by { |doc| doc.date || Time.at(0) }
          .reverse
          .first(MAX_FEED_ITEMS)
    end

    def feed_page_for(site, collection)
      site.pages.find { |page| page.data["feed_collection"] == collection }
    end

    def thought_title_from_content(content)
      text = content.to_s.strip
      first_line = text.lines.first.to_s.strip
      first_line = first_line.gsub(/\[([^\]]+)\]\([^)]+\)/, '\1')
      first_sentence = first_line.split(/(?<=[.!?])\s/).first.to_s.strip
      candidate = first_sentence.empty? ? first_line : first_sentence
      return candidate if candidate.length <= THOUGHT_TITLE_MAX_LENGTH

      truncated = candidate[0...THOUGHT_TITLE_MAX_LENGTH]
      truncated = truncated.sub(/\s+\S*\z/, "")
      "#{truncated.rstrip}..."
    end

    def apply_thought_link_metadata(doc)
      ThoughtLinkMetadata.enrich_data!(doc.data)
    end

    def limit_with_url
      # match the value used for append_url_spacer in the feed pages
      spacer = "\n\n".length
      { max: X_TWITTER_MAX_LENGTH, reserved_for_url: 23, spacer: }
    end

    def limit_without_url
      { max: X_TWITTER_MAX_LENGTH, reserved_for_url: 0, spacer: 0 }
    end
  end
end
