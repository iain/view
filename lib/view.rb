module View

  autoload :Formatter, 'view/formatter'
  autoload :Helper,    'view/helper'
  autoload :VERSION,   'view/version'

  mattr_accessor :guessing_methods
  self.guessing_methods = %w|to_label display_name full_name name title username login value to_s|

  mattr_accessor :file_methods
  self.file_methods = %w|mounted_as file? public_filename|

  mattr_accessor :path_methods
  self.path_methods = %w|mounted_as url public_filename|

  mattr_accessor :path_arguments
  self.path_arguments = []

  mattr_accessor :default_formatter
  self.default_formatter = :auto

  mattr_accessor :formatters


  def self.to_s(value, options = {}, template = nil, &block)
    Formatter.to_s(value, options, template, &block)
  end

end
