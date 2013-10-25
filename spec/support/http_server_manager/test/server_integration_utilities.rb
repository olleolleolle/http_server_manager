module HttpServerManager
  module Test

    module ServerIntegrationUtilities

      def force_start!
        server.start!
        wait_until_started!
      end

      alias_method :force_server_start!, :force_start!

      def force_stop!
        server.stop!
        wait_until_stopped!
      end

      alias_method :force_server_stop!, :force_stop!

      def force_pid_file_creation!
        File.open(pid_file_path, "w") { |file| file.write "0" }
        wait_until_file_exists!(pid_file_path)
      end

      def force_pid_file_deletion!
        FileUtils.rm_f(pid_file_path)
        ::Wait.until_false!("#{pid_file_path} is deleted") { pid_file_exists? }
      end

      def restore_pid_file!
        FileUtils.cp(pid_file_backup_path, pid_file_path)
        wait_until_file_exists!(pid_file_path)
      end

      def wait_until_started!
        ::Wait.until_true!("#{server.name} starts") do
          !!Net::HTTP.get_response(server.host, "/", server.port) && pid_file_exists?
        end
        FileUtils.cp(pid_file_path, pid_file_backup_path)
      end

      def wait_until_stopped!
        ::Wait.until_true!("#{server.name} stops") do
          begin
            Net::HTTP.get_response(server.host, "/", server.port)
            false
          rescue
            !pid_file_exists?
          end
        end
      end

      def wait_until_file_exists!(file)
        ::Wait.until_true!("#{file} exists") { File.exists?(file) }
      end

      def ensure_pid_file_backup_directory_exists!
        FileUtils.mkdir_p(pid_file_backup_directory)
        wait_until_file_exists!(pid_file_backup_directory)
      end

      def pid_file_exists?
        File.exists?(pid_file_path)
      end

      def pid_file_path
        "#{pid_dir}/#{pid_file_name}"
      end

      def pid_file_name
        "#{server.name}.pid"
      end

      def pid_file_backup_directory
        "#{pid_dir}/backup"
      end

      def pid_file_backup_path
        "#{pid_file_backup_directory}/#{pid_file_name}"
      end

      def pid_dir
        HttpServerManager.pid_dir
      end

      def logger
        HttpServerManager.logger
      end

      def log_dir
        HttpServerManager.log_dir
      end

    end

  end
end
