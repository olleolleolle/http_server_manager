require 'rake/tasklib' unless defined? ::Rake::TaskLib

module HttpServerManager
  module Rake

    class ServerTasks < ::Rake::TaskLib

      def initialize(server)
        define_start_task(server)
        define_stop_task(server)
        define_restart_task(server)
        define_status_task(server)
      end

      private

      def define_start_task(server)
        desc "Start a #{server.name} as a background process"
        task :start do
          server.start!
        end
      end

      def define_stop_task(server)
        desc "Stop a running #{server.name}"
        task :stop do
          server.stop!
        end
      end

      def define_restart_task(server)
        desc "Restart an potentially running #{server.name}"
        task :restart do
          server.restart!
        end
      end

      def define_status_task(server)
        desc "Display the status of a #{server.name} process"
        task :status do
          puts "#{server.name} is #{server.status}"
        end
      end

    end

  end
end
