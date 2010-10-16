require "rubygems"
require "bundler/setup"
Bundler.setup :default

require 'rails'
require 'action_view'

# Needed to make the capture helper work in tests
require 'action_view/template/handlers/erb'

require 'rspec'
require 'view'

module WithTranslation

  # Temporarily use a clean 'test'-locale
  #
  # with_translation :foo => 'bar' do
  #   I18n.t(:foo).should == 'bar'
  # end
  # I18n.t(:foo).should_not == 'bar'
  def with_translation(keys)
    locale = I18n.locale
    I18n.locale = :test
    I18n.backend.reload!
    I18n.backend.store_translations(:test, keys)
    yield
  ensure
    I18n.backend.reload!
    I18n.locale = locale
  end

end


module TemplateHelper

  # make it act like a helper spec
  def helper
    @helper ||= Template.new
  end

  # emulate a Rails view
  class Template < ActionView::Base
    include View::Helper
  end

end

RSpec.configure do |config|
  config.include(WithTranslation)
  config.include(TemplateHelper)
end
