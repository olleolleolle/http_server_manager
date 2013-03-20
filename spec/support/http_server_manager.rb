require_relative "http_server_manager/silent_logger"

module HttpServerManager

  def self.root
    @root ||= File.expand_path("../../../", __FILE__)
  end

end

HttpServerManager.logger = HttpServerManager::SilentLogger
HttpServerManager.pid_dir = "#{HttpServerManager.root}/tmp/pids"
HttpServerManager.log_dir = "#{HttpServerManager.root}/tmp/logs"
