module View

  class Link < Formatter

    self.reserved_options = [ :to, :path, :text ]

    def format
      template.link_to(text, to, options)
    end

    def to
      all_options[:to] || template.polymorphic_path(automatic_link)
    end

    def automatic_link
      ::Array.wrap(all_options[:path]) + [ value ]
    end

    def text
      all_options[:text] || format
    end

    def as
      :guess
    end

  end

end
