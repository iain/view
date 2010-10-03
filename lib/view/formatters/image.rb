module View

  class Image < Formatter

    self.reserved_options = [ :with ]

    def to_s
      template.image_tag(path, options) if file?
    end

    def path
      value.send(path_method, *path_arguments)
    end

    # TODO I'm only guessing here, I don't actually know how other upload gems
    # work, besides paperclip.
    def path_method
      View.path_methods.find { |method| value.respond_to?(method) }
    end

    # TODO with seems like a stupid name, but style is probably used for
    # image_tag
    def path_arguments
      all_options[:with] || View.path_arguments
    end

    def file?
      value.send(file_method)
    end

    def file_method
      View.file_methods.find { |method| value.respond_to?(method) }
    end

  end

end
