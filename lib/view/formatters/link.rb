module View

  class Link < Formatter

    self.reserved_options = [ :to, :path, :text ]

    def to_s
      template.link_to(format, to, options)
    end

    def to
      all_options[:to] || template.polymorphic_path(automatic_link)
    end

    def automatic_link
      (all_options[:path] || []) + [ value ]
    end

    def as
      all_options[:text] || :auto
    end

  end

end