require "bundler/gem_tasks"

# Console
desc "Open an console session preloaded with this library"
task :console do
  sh "pry -r ./lib/hetchy.rb"
end

# Testing
require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test
