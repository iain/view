module View

  autoload :Formatter,     'view/formatter'
  autoload :Helper,        'view/helper'
  autoload :Configuration, 'view/configuration'
  autoload :VERSION,       'view/version'

  # This is the main method to use this gem. Any formatting from outside this
  # gem should be done through this method (notwithstanding custom formatters).
  #
  # In every day usage you will access it through the +view+ helper method,
  # because most formatters require a view to render links or images.
  #
  # @see View::Helper#view
  #
  # @example Rendering a link
  #   module PostsHelper
  #     def link_to_post
  #       View.format @post, { :as => :link }, self
  #     end
  #   end
  #
  # @param [Object] value the object to be shown
  # @param [Hash] options Any extra options
  #
  # @option options [Symbol] :as (:auto) The name of the formatter
  # @option options [::Array] :block_arguments ([]) Adds arguments passed to
  #   the block of this method.
  #
  # @param [ActionView::Template] Template the view instance on which to call
  #   helper methods like +link_to+ and +image_tag+.
  #   You need this for many formatters.
  #
  # @yield [formatter] The block will be captured (using the template if
  #   possible) so you can use the formatter in more interesting ways.
  #
  # @return [String] the object formatted to a string
  def self.format(value, options = {}, template = nil, &block)
    Formatter.format(value, options, template, &block)
  end

  # Access to the configuration object
  # @return [Configuration]
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Configures this gem
  #
  # @example config/initializers/view.rb
  #
  #   View.configure do |config|
  #     config.default_formatter = :self
  #   end
  #
  # @yield [config] The configuration instance
  def self.configure
    yield configuration
  end

  # Contains a list of registered formatters
  def self.formatters
    @formatters ||= []
  end

end

require 'view/railtie'
