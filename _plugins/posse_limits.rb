module Jekyll
  class PosseLimits < Generator
    safe true
    priority :low

    # X/Twitter has the shortest character limit of all the platforms
    # we care about.
    X_TWITTER_MAX_LENGTH = 280

    MAX_FEED_ITEMS = 25

    def generate(site)
      articles = feed_docs(site.posts.docs)
      thoughts = feed_docs(site.collections.fetch("thoughts").docs)
      talks = feed_docs(site.collections.fetch("talks").docs)
      interviews = feed_docs(site.collections.fetch("interviews").docs)

      errors = []
      validate_collection(articles, limit_with_url, errors, method(:article_text))
      validate_collection(talks, limit_with_url, errors, method(:talk_text))
      validate_collection(interviews, limit_with_url, errors, method(:interview_text))
      validate_collection(thoughts, limit_without_url, errors, method(:thought_text))
      return if errors.empty?

      raise Jekyll::Errors::FatalException, "POSSE text too long: #{errors.join(", ")}"
    end

    private

    def feed_docs(docs)
      docs.sort_by { |doc| doc.date || Time.at(0) }
          .reverse
          .first(MAX_FEED_ITEMS)
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
      publication = doc.data.fetch("publication").to_s
      render_format(format_string, title:, publication:)
    end

    def thought_text(doc)
      doc.content
    end

    def format_string_for(collection, site)
      page = site.pages.find { |p| p.data["feed_collection"] == collection }
      page.data.fetch("posse_post").fetch("format_string")
    end

    def render_format(format_string, variables)
      Liquid::Template.parse(format_string)
                      .render(variables.transform_keys(&:to_s))
    end

    def limit_with_url
      { max: X_TWITTER_MAX_LENGTH, reserved_for_url: 23, spacer: 1 }
    end

    def limit_without_url
      { max: X_TWITTER_MAX_LENGTH, reserved_for_url: 0, spacer: 0 }
    end
  end
end
