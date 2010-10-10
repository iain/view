module View

  # Handy for paperclip attachment objects, this formatter will find out what
  # the url is and make a link to that.
  #
  # Controll the link with the :text or :text_method option.
  #
  # @example
  #
  #   <%= view @user.avatar %>
  #   <%= view @user.avatar, :text => "Click for the avatar" %>
  #   <%= view @user.avatar, :text_method => :original_file_name %>
  #
  # By default, all links have the target _blank, so they won't screw up your
  # site. Turn it off globally by putting:
  #
  #   View::FileLink.default_options = {}
  class FileLink < Formatter

    self.reserved_options = [ :text, :text_method ]
    self.default_options = { :target => "_blank" }

    def format
      template.link_to(text, path, options)
    end

    def path
      View.path_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
      nil
    end

    def text
      all_options[:text] || formatted_text
    end

    def formatted_text
      View.format((text_via_method || value), {:as => :guess}, template, &block)
    end

    def text_via_method
      value.send(text_method) if text_method
    end

    def text_method
      all_options[:text_method]
    end

  end

end
