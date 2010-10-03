require 'rubygems'
require 'bundler/setup'
Bundler.setup :default
require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--color'
end

task :default => :spec
