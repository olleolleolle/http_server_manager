class RackServer < HttpServerManager::Server

  def initialize(options)
    super({ name: "rack_server" }.merge(options))
  end

  def start_command
    "rackup -p #{@port} #{File.expand_path("../server_config.ru", __FILE__)}"
  end

end
