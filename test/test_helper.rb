require 'bundler'
Bundler.setup

require 'pry'
require 'minitest/autorun'

require 'hetchy'

Dir[File.dirname(__FILE__) + '/support/*.rb'].each {|file| require file }