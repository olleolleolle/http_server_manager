require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 100
  refuse_coverage_drop
end if ENV["coverage"]

require_relative '../lib/http_server_manager'
require_relative '../lib/http_server_manager/rake/task_generators'

module HttpServerManager

  def self.root
    @root ||= File.expand_path("../../../", __FILE__)
  end

end

require_relative 'support/http_server_manager/test/silent_logger'
HttpServerManager.logger = HttpServerManager::Test::SilentLogger
HttpServerManager.pid_dir = "#{HttpServerManager.root}/tmp/pids"
HttpServerManager.log_dir = "#{HttpServerManager.root}/tmp/logs"

Bundler.require(:test)

require_relative '../examples/rack_server'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }
