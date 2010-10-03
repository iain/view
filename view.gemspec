require File.expand_path('../lib/view/version', __FILE__)

Gem::Specification.new do |s|

  s.name             = "view"
  s.version          = View::VERSION
  s.platform         = Gem::Platform::RUBY

  s.authors          = ["Iain Hecker" ]
  s.email            = ["iain@iain.nl"]
  s.homepage         = "http://github.com/iain/view"

  s.summary          = "Displaying objects automatically"
  s.description      = "A very extensible way of viewing objects, easily integrated with other gems"

  s.rubyforge_project = "view"

  s.require_path     = "lib"
  s.required_rubygems_version = ">= 1.3.6"

  s.files            = Dir["lib/**/*.rb"] + ['init.rb']

end
