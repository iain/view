module View

  # Makes an image tag. It also works with paperclip objects.
  #
  # With paperclip, it also checks if the file was really uploaded.
  #
  # This is actually longer than the regular Rails way. But the added benefit
  # of this formatter comes from using it inside the table and definition list
  # formatter.
  #
  # @example Without paperclip
  #
  #   = view "foo.jpg", :as => :image
  #
  # @example With paperclip
  #
  #   = view @user.avatar, :as => :image
  #
  # @example With options
  #
  #   = view @user.avatar, :as => :image, :html => { :class => "meh" }
  #
  # @example Inside the definition_list formatter:
  #
  #   = definition_list_for @user do |dl|
  #     = dl.view :name
  #     = dl.view :avatar, :as => :image
  #
  #
  class Image < Formatter

    self.default_options = { :html => {} }

    def format
      template.image_tag(path, options) if file?
    end

    # Returns the path of the image, based on the path_methods and
    # path_arguments configuration.
    def path
      if value.is_a?(String)
        value
      else
        value.send(path_method, *path_arguments)
      end
    end

    # The options for the image tag are in the :html option.
    # You can use the default options to change them.
    #
    # @example
    #
    #   View::Image.default_options = { :html => { :class => "avatar" } }
    def options
      super[:html]
    end

    # TODO I'm only guessing here, I don't actually know how other upload gems
    # work, besides paperclip.
    def path_method
      View.configuration.path_methods.find { |method| value.respond_to?(method) }
    end

    def path_arguments
      all_options[:style] || View.configuration.path_arguments
    end

    def file?
      value.is_a?(String) || value.send(file_method)
    end

    def file_method
      View.configuration.file_methods.find { |method| value.respond_to?(method) }
    end

  end

end
