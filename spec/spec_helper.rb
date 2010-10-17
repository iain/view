require "rubygems"
require "bundler/setup"
Bundler.setup :default

require 'rails'
require 'action_view'

# Needed to make the capture helper work in tests
require 'action_view/template/handlers/erb'

# We need them all
require 'active_support/core_ext'

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

# Make a fake Rails application, to test rendering partials
class RailsApplication

  def root
    File.expand_path('../../', __FILE__)
  end

  def config
    Struct.new(:root, :cache_classes, :assets_dir).new(root, false, root)
  end

  # This runs before every spec
  def before(context)
    Rails.stub(:application).and_return(self)
    ActionView::Template.register_default_template_handler :erb, ActionView::Template::Handlers::ERB
    context.helper.view_paths = view_paths
  end

  def view_paths
    [ File.join(root, 'app', 'views') ]
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

    def config
      Struct.new(:asset_path, :asset_host).new('/', '/')
    end
  end

end

RSpec.configure do |config|
  config.include(WithTranslation)
  config.include(TemplateHelper)
  config.before do
    RailsApplication.new.before(self)
  end
  # Uncomment to see the big backtrace
  # config.backtrace_clean_patterns = []
end
