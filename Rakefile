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
  gem.name = "profile-formatter"
  gem.version = "0.1"
  gem.homepage = "http://github.com/headshift/profile-formatter"
  gem.license = "MIT"
  gem.summary = %Q{A Cucumber output formatter providing profiling information}
  gem.description = %Q{A Cucumber output formatter providing profiling information about the time it takes to run steps and examples}
  gem.email = "alessandro@headshift.com"
  gem.authors = ["Alessandro Morandi"]
  gem.add_dependency "cucumber", ">= 0.4"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "profile-formatter #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
