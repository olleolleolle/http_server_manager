require 'rake/tasklib' unless defined? (::Rake::TaskLib)

module HttpServerManager

  module Rake

    class ServerTasks < ::Rake::TaskLib

      def initialize(server)
        desc "Starts a #{server.name} as a background process"
        task :start do
          server.start!
        end

        desc "Stops a running #{server.name}"
        task :stop do
          server.stop!
        end

        desc "Displays the status of a #{server.name} process"
        task :status do
          puts "#{server.name} is #{server.status}"
        end
      end

    end

  end

end
