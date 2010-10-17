module View

  # The central place for all configuration.
  class Configuration

    # Used by the guess filter, these are the methods used to format an object.
    # It will use the first method that the object responds to.
    attr_accessor :guessing_methods

    # To determine if something is an uploaded image, it checks
    # to see whether it responds to one of these methods.
    attr_accessor :file_methods

    # To show an image, it will use one of these methods to get the src
    # attribute.
    attr_accessor :path_methods

    # You can set a default argument for rendering images, like the style or size
    # of the image. It will be passed to one of the path_methods.
    attr_accessor :path_arguments

    # Which formatter will be used by default. The default is auto, which does
    # all sorts of interesting stuff to see what to do.
    attr_accessor :default_formatter

    # The auto formatter will choose this formatter by default when your value is
    # an array (or really, something that responds to +each+).
    attr_accessor :default_list_formatter

    # Shorthand for configuring this gem.
    #
    # @example In +config/initializers/view.rb+
    #
    #   View.configure do |config|
    #     config.default_formatter = :self
    #   end
    #
    # @yield [config] The View module
    def configure
      yield self
    end

    def initialize
      self.guessing_methods       = %w|to_label display_name full_name name title
                                       username login value to_s|
      self.file_methods           = %w|file? mounted_as public_filename|
      self.path_methods           = %w|url mounted_as public_filename|
      self.path_arguments         = []
      self.default_formatter      = :auto
      self.default_list_formatter = :sentence
    end

  end

end
