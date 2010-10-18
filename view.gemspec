require File.expand_path('../lib/view/version', __FILE__)

Gem::Specification.new do |s|

  s.name              = "view"
  s.version           = View::VERSION
  s.platform          = Gem::Platform::RUBY
  s.date              = Date.today.to_s

  s.authors           = ["Iain Hecker" ]
  s.email             = ["iain@iain.nl"]
  s.homepage          = "http://github.com/iain/view"

  s.summary           = "Displaying objects automatically"
  s.description       = "A very extensible way of viewing objects"

  s.rubyforge_project = s.name

  s.require_path      = "lib"

  s.files             = Dir["{lib,app}/**/*.rb"] + ['init.rb']
  s.test_files        = Dir["spec/**/*"]
  s.extra_rdoc_files  = ["README.rdoc"]

  s.add_dependency "rails", "~> 3.0.0"

  s.required_rubygems_version = ">= 1.3.6"
end
