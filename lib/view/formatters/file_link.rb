module View

  class FileLink < Formatter

    self.reserved_options = [ :text, :text_method ]
    self.default_options = { :target => "_blank" }

    def to_s
      template.link_to(text, path, options)
    end

    def path
      View.path_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
      nil
    end

    def text
      all_options[:text] || text_via_method || value.to_s
    end

    def text_via_method
      send(text_method) if text_method
    end

    def text_method
      all_options[:text_method]
    end

  end

end
