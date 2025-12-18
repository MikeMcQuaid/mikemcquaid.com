module Jekyll
  class CustomSeoTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      output = Liquid::Template.parse("{% seo %}").render!(context)

      page = context.registers[:page] || {}
      return output if page["collection"] != "thoughts"

      output.gsub(%r{\n?\s*<meta\s+property="twitter:title"\s+content="[^"]*"\s*/>\s*}i, "\n")
            .gsub(%r{\n?\s*<meta\s+name="twitter:title"\s+content="[^"]*"\s*/>\s*}i, "\n")
    end
  end
end

Liquid::Template.register_tag("seo_custom", Jekyll::CustomSeoTag)
