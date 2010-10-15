require "rubygems"
require "bundler/setup"
Bundler.setup :default
require 'rails'
require 'action_view'
require 'rspec'
require 'view'

module WithTranslation
  def with_translation(keys)
    locale = I18n.locale
    I18n.backend.store_translations(:test, keys)
    I18n.locale = :test
    yield
  ensure
    I18n.locale = locale
  end
end


module TemplateHelper

  # make it act like a helper spec
  def helper
    @helper ||= Template.new
  end

  class Template

    include ActionView::Helpers
    include View::Helper

  end

end

RSpec.configure do |config|
  config.include(WithTranslation)
  config.include(TemplateHelper)
end
