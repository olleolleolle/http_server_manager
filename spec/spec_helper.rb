require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require_relative "../lib/http_server_manager"

require 'rubygems'
require 'bundler'
Bundler.require(:test)

require 'sys/proctree'
require 'wait_until'

require_relative "support/http_server_manager"
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }
