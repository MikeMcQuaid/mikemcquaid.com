module Jekyll
  class CustomSeoTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      output = Liquid::Template.parse("{% seo %}")
                               .render!(context)
                               .gsub(/\s*<!-- Begin Jekyll SEO tag v\d+\.\d+\.\d+ -->\s*/, "")
                               .gsub(/\s*<!-- End Jekyll SEO tag -->\s*/, "")

      page = context.registers.fetch(:page)
      return output if page["collection"] != "thoughts"

      site = context.registers.fetch(:site)
      site_title = site.config.fetch("title")
      return output unless site_title

      output.gsub(%r{(<meta\s+(?:property|name)="og:title"\s+content=")[^"]*("\s*/>)}i,
                  "\\1#{site_title}\\2")
            .gsub(%r{(<meta\s+(?:property|name)="twitter:title"\s+content=")[^"]*("\s*/>)}i,
                  "\\1#{site_title}\\2")
    end
  end
end

Liquid::Template.register_tag("seo_custom", Jekyll::CustomSeoTag)
