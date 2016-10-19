module HttpServerManager

  class Server

    attr_reader :name, :host, :port

    def initialize(options)
      @name                = options[:name]
      @host                = options[:host]
      @port                = options[:port]
      @ping_uri            = options[:ping_uri] || "/"
      @timeout_in_seconds  = options[:timeout_in_seconds] || (ENV["timeout"] ? ENV["timeout"].to_i : 20)
      @deletable_artifacts = [ pid_file_path ]
    end

    def start!
      if running?
        logger.info "#{@name} already running on #{@host}:#{@port}"
      else
        ensure_directories_exist
        pid = Process.spawn(start_command, [:out, :err] => [ log_file_path, "w" ])
        create_pid_file(pid)
        Wait.until_true!(description: "#{@name} is running", timeout_in_seconds: @timeout_in_seconds) { running? }
        logger.info "#{@name} started on #{@host}:#{@port}"
      end
    end

    def stop!
      if running?
        Process.kill_tree(9, current_pid)
        FileUtils.rm_f(@deletable_artifacts)
        logger.info "#{@name} stopped"
      else
        logger.info "#{@name} not running"
      end
    end

    def restart!
      stop!
      start!
    end

    def status
      running? ? :started : :stopped
    end

    def to_s
      "#{@name} on #{@host}:#{@port}"
    end

    def logger
      HttpServerManager.logger
    end

    private

    def running?
      !!(Net::HTTP.new(@host, @port).start do |http|
        http.open_timeout = http.read_timeout = @timeout_in_seconds
        http.request_get(@ping_uri)
      end)
    rescue
      false
    end

    def current_pid
      File.exist?(pid_file_path) ? File.read(pid_file_path).to_i : nil
    end

    def pid_file_path
      File.join(pid_dir, "#{@name}.pid")
    end

    def create_pid_file(pid)
      File.open(pid_file_path, "w") { |file| file.write(pid) }
    end

    def log_file_path
      File.join(log_dir, "#{@name}_console.log")
    end

    def ensure_directories_exist
      FileUtils.mkdir_p([pid_dir, log_dir])
    end

    def pid_dir
      HttpServerManager.pid_dir
    end

    def log_dir
      HttpServerManager.log_dir
    end

  end

end
