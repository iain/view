module View

  autoload :Formatter, 'view/formatter'
  autoload :Helper,    'view/helper'
  autoload :VERSION,   'view/version'

  # Used by the guess filter, these are the methods used to format an object.
  # It will use the first method that the object responds to.
  mattr_accessor :guessing_methods
  self.guessing_methods = %w|to_label display_name full_name name title username login value to_s|

  # To determine if something is an uploaded image, it checks
  # to see whether it responds to one of these methods.
  mattr_accessor :file_methods
  self.file_methods = %w|mounted_as file? public_filename|

  # To show an image, it will use one of these methods to get the src
  # attribute.
  mattr_accessor :path_methods
  self.path_methods = %w|mounted_as url public_filename|

  # You can set a default argument for rendering images, like the style or size
  # of the image. It will be passed to one of the path_methods.
  mattr_accessor :path_arguments
  self.path_arguments = []

  # Which formatter will be used by default. The default is auto, which does
  # all sorts of interesting stuff to see what to do.
  mattr_accessor :default_formatter
  self.default_formatter = :auto

  # Holds a list of formatters. It will be filled automatically by inheriting
  # from View::Formatter.
  mattr_accessor :formatters

  # Shorthand for accessing the formatter.
  #
  #   View.to_s @post, :as => :link
  #
  # @param [Object] value the object to be shown
  # @param [Hash] options any extra options, most importantly +:as+ to specify
  #                       the formatter
  # @param [ActionView::Template] template the view instance on which to call
  #                                        helper methods like +link_to+ and +image_tag+
  # @return [String] the object formatted to a string
  def self.to_s(value, options = {}, template = nil, &block)
    Formatter.to_s(value, options, template, &block)
  end

end
