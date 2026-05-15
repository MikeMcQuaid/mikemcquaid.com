require "time"

module Jekyll
  class HomepageSelection < Generator
    safe true
    priority :lowest

    HOMEPAGE_LIMIT = 16
    TYPE_ORDER = %w[posts interviews talks podcasts].freeze
    WEIGHTED_CYCLE = %w[posts interviews posts talks posts interviews podcasts posts].freeze

    def generate(site)
      items = select_items(
        site.posts.docs +
        site.collections.fetch("interviews").docs +
        site.collections.fetch("talks").docs +
        Array(site.data.dig("podcasts_external", "items"))
      )
      items.each { |item| add_homepage_image(item) }
      site.data["homepage_items"] = items
    end

    private

    def select_items(items)
      queues = TYPE_ORDER.to_h do |type|
        [type, items.select { |item| item_type(item) == type }.sort_by { |item| item_date(item) }.reverse]
      end
      selected = TYPE_ORDER.filter_map { |type| queues.fetch(type).shift }
      cycle_index = 0

      while selected.length < HOMEPAGE_LIMIT && queues.values.any?(&:any?)
        offset = next_offset(queues, cycle_index, item_type(selected.last), skip_last_type: true) ||
                 next_offset(queues, cycle_index, item_type(selected.last), skip_last_type: false)
        break unless offset

        cycle_index += offset
        selected << queues.fetch(WEIGHTED_CYCLE.fetch(cycle_index % WEIGHTED_CYCLE.length)).shift
        cycle_index += 1
      end

      selected
    end

    def next_offset(queues, cycle_index, last_type, skip_last_type:)
      WEIGHTED_CYCLE.length.times do |offset|
        type = WEIGHTED_CYCLE.fetch((cycle_index + offset) % WEIGHTED_CYCLE.length)
        next if queues.fetch(type).empty?
        next if skip_last_type && type == last_type

        return offset
      end

      nil
    end

    def item_type(item)
      return nil if %w[false no 0 hidden].include?(value_for(item, "homepage").downcase) ||
                    %w[true yes 1].include?(value_for(item, "hide_from_homepage").downcase)
      return "podcasts" if value_for(item, "source_feed_url") != "" && value_for(item, "podcast_audio_url") != ""

      item.collection.label
    end

    def add_homepage_image(item)
      image = %w[link_image image thumbnail cover_image cover poster og_image card_image]
              .map { |key| value_for(item, key) }
              .find { |value| value != "" }.to_s
      image = "" if image == "/images/default-card.jpg"
      youtube_id = value_for(item, "youtube-id")
      image = "/images/media/youtube/#{youtube_id}.jpg" if image == "" && youtube_id != ""
      youtube_link_match = value_for(item, "link").match(%r{youtube\.com/watch\?v=([^&]+)})
      image = "/images/media/youtube/#{youtube_link_match[1]}.jpg" if image == "" && youtube_link_match
      content_image_match = item.content.match(%r{/images/[^'")\]\s]+}) if image == "" && item.respond_to?(:content)
      image = content_image_match[0] if image == "" && content_image_match
      item.data["homepage_image"] = image if image != "" && item.respond_to?(:data)
      item
    end

    def item_date(item)
      return item.date if item.respond_to?(:date) && item.date

      Time.parse(value_for(item, "date"))
    end

    def value_for(item, key)
      return item.data.fetch(key, "").to_s if item.respond_to?(:data)

      item.fetch(key, "").to_s
    end
  end
end
