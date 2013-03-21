http_server_manager
====================

Aims to simplify managing the lifecycle of HTTP server processes.

Given a server start-up command, ```http_server_manager``` can:

* Start the server, generate a pid file, redirect stdout and stderr to a log file and poll until the server has started
* Provide the status of the server (started or stopped)
* Stop the server, killing the servers process tree and deleting the generated pid file

It is currently distributed as a development and testing tool and is not recommended for production use.

Motivation
----------

For projects whose production environment is completed managed by a PaaS provider, such as Heroku or Engine Yard,
using ```god``` or ```monit``` to manage your http processes in development and test environments can be overkill.

```http_server_manager``` provides a simple means on managing the lifecycle of these processes in these environments.

It is particularly useful for automated start and stop of these processes as part of a continuous integration pipeline.

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
            super(name: :my_server, port: 3000)
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

Alternatively, via Rake:

```ruby
    require 'http_server_manager/rake/task_generators'

    HttpServerManager::Rake::ServerTasks.new(server)
    # Generates tasks:
    # my_server:start
    # my_server:stop
    # my_server:status
```

Testing
-------

Ensure that your server is configured correctly:

```ruby
    require 'http_server_manager/test_support'

    describe MyServer do

      include_context "managed http server integration utilities" # Provided by http_server_manager as a test utility

      let(:server) { MyServer.new }

      describe "#start!" do

        after(:each) { force_stop! }

        it "should start the server via the provided command" do
          server.start!

          wait_until_started!
        end

      end
```

For those not using RSpec, see http_server_manager/test/server_integration_utilities.rb

OS Support
----------

Mac and Windows

Requirements
------------

* Ruby 1.9

Build Status
------------

[![Build Status](https://travis-ci.org/MYOB-Technology/http_server_manager.png)](https://travis-ci.org/MYOB-Technology/http_server_manager)
