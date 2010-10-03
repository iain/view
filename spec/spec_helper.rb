require "rubygems"
require "bundler/setup"
Bundler.setup :default
require 'active_support'
require 'active_support/core_ext'
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

RSpec.configure do |config|
  config.include(WithTranslation)
end
