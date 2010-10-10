module View

  autoload :Formatter, 'view/formatter'
  autoload :Helper,    'view/helper'
  autoload :VERSION,   'view/version'

  class << self
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

    # Holds a list of formatters. It will be filled automatically by inheriting
    # from View::Formatter.
    attr_accessor :formatters

    # If true, before any other formatter, check to see if the value is blank,
    # and use the blank formatter if it is. (default is true).
    # Individual formatters can override this
    attr_accessor :always_format_blank

    # The method used to check if an object is blank. Defaults to :blank?, but
    # can also be something like :nil?
    attr_accessor :blank_check_method

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

  end

  self.guessing_methods       = %w|to_label display_name full_name name title
                                   username login value to_s|
  self.file_methods           = %w|mounted_as file? public_filename|
  self.path_methods           = %w|mounted_as url public_filename|
  self.path_arguments         = []
  self.default_formatter      = :auto
  self.default_list_formatter = :sentence
  self.always_format_blank    = true
  self.blank_check_method     = :blank?


  # This is the main method to use this gem. Any formatting from outside this
  # gem should be done through this method (notwithstanding custom formatters).
  #
  # In every day usage you will access it through the +view+ helper method,
  # because most formatters require a view to render links or images. Any
  # helper method should also point to this method.
  #
  # @see View::Helper#view
  #
  # @example Rendering a link
  #   module PostsHelper
  #     def link_to_post
  #       View.format @post, :as => :link, self
  #     end
  #   end
  #
  # @param [Object] value the object to be shown
  # @param [Hash] options Any extra options
  #
  # @option options [Symbol] :as (:auto) The name of the formatter
  # @option options [Array] :block_arguments (nil) Overrides the arguments passed to
  #   the block of this method.
  #
  # @param [ActionView::Template] Template the view instance on which to call
  #   helper methods like +link_to+ and +image_tag+.
  #   You need this for many formatters.
  #
  # @yield [formatted_string] The block will be captured (using the template if
  #   possible) to alter the formatted string that would otherwise be returned.
  #   Consider it as a final modifier after the view formatter has done its
  #   work.
  #
  # @return [String] the object formatted to a string
  def self.format(value, options = {}, template = nil, &block)
    Formatter.format(value, options, template, &block)
  end

end
