class RackServer < HttpServerManager::Server

  def initialize(options)
    super(options)
  end

  def start_command
    "rackup --host #{host} --port #{port} #{File.expand_path("../server_config.ru", __FILE__)}"
  end

end
