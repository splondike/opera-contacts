# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "opera-contacts"
  gem.homepage = "http://github.com/splondike/opera-contacts"
  gem.license = "BSD 2-Clause"
  gem.summary = %Q{Parse library for the Opera browser contacts file}
  gem.description = %Q{Parses the opera browser contacts file (ending in .adr) to a ruby data structure. This can then be exported to vCard or whatever.}
  gem.email = "code@stefansk.name"
  gem.authors = ["Stefan Schneider-Kennedy"]
  gem.version = "0.0.0"
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "opera-contacts #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# vim: ft=ruby et sw=2 ts=2 sts=2
