# frozen_string_literal: true

module PodcastFeedItemHelpers
  module_function

  def feed_items(doc)
    items = doc.xpath("/rss/channel/item")
    items = doc.xpath("/feed/entry") if items.empty?
    items
  end

  def text_at(node, xpath)
    node.at_xpath(xpath)&.text.to_s.gsub(/\s+/, " ").strip
  end

  def item_link(item)
    link = text_at(item, "./link")
    return link unless link.empty?

    atom_link = item.at_xpath("./link[@rel='alternate']") || item.at_xpath("./link[not(@rel)]")
    atom_link&.[]("href").to_s.strip
  end

  def audio_data(item)
    enclosure = item.at_xpath("./enclosure")
    enclosure ||= item.at_xpath("./link[@rel='enclosure']")

    audio_url = enclosure&.[]("url").to_s.strip
    audio_url = enclosure&.[]("href").to_s.strip if audio_url.empty?
    audio_type = enclosure&.[]("type").to_s.strip
    audio_length = enclosure&.[]("length").to_s.strip

    return { url: "", type: "", length: "" } if audio_length == "0"
    return { url: "", type: "", length: "" } if !audio_type.empty? && !audio_type.downcase.start_with?("audio/")

    {
      url: audio_url,
      type: audio_type,
      length: audio_length
    }
  end
end
