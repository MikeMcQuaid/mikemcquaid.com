module Jekyll
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content, 
        { :style => :expanded, 
          :syntax => :scss })
      engine.render
    end
  end
end