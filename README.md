http_server_manager
====================

Aims to simplify managing the lifecycle of HTTP server processes.

Given a server start-up command, ```http_server_manager``` can:

* Start the server, generate a pid file, redirect stdout and stderr to a log file and poll until the server has started
* Provide the status of the server (started or stopped)
* Stop the server, killing the servers process tree and deleting the generated pid file

It is currently distributed as a development and testing tool and is not recommended for production use.

Usage
-----

Step 1:  Install via ```gem install http_server_manager``` or ```gem 'http_server_manager``` in your Gemfile

Step 2:  Require:

```ruby
    require 'http_server_manager'
```

Step 3:  Configure the location of server pid files and logs:

```ruby
    HttpServerManager.pid_dir = "some/pid/dir"
    HttpServerManager.log_dir = "some/log/dir"
```

Step 4:  Create a server class:

```ruby
    require 'http_server_manager'

    class MyServer < HttpServerManager::Server

        def initialize
            super(name: "My Server", port: 3000)
        end

        def start_command
          "rackup -p #{@port} my/server_config.ru"
        end

    end
```

Step 5:  Control the status of the server:

```ruby
    server = MyServer.new

    server.start! # blocks until server is running

    server.status # returns :started

    server.stop! # kills process

    server.status # returns :stopped
```

OS Support
----------

Mac and Windows

Requirements
------------

* Ruby 1.9.3
