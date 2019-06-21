class RackServer < HttpServerManager::Server

  def initialize(options)
    super(options)
  end

  def start_command
    "rackup --host #{host} --port #{port} #{File.expand_path("rack_application.ru", __dir__)}"
  end

end
