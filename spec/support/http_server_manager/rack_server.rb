module HttpServerManager

  class RackServer < HttpServerManager::Server

    def initialize(options)
      super({ name: "rack_server" }.merge(options))
    end

    def start_command
      "rackup -p #{@port} #{HttpServerManager.root}/spec/resources/server_config.ru"
    end

  end

end
