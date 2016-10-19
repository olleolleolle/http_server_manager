describe HttpServerManager::Server, "managing a real server" do
  include_context "managed http server integration utilities"

  let(:name)                   { "test_server" }
  let(:host)                   { "localhost" }
  let(:port)                   { 4001 }
  let(:additional_server_args) { {} }
  let(:server_args)            { { name: name, host: host, port: port }.merge(additional_server_args) }

  let(:server) { RackServer.new(server_args) }

  describe "#start!" do

    after(:example) { force_stop! }

    context "when the server is not running" do

      after(:example) { wait_until_started! } # Ensure server has completely started

      it "starts the server via the provided command" do
        server.start!

        wait_until_started!
      end

      it "creates a pid file for the server in the configured pid directory" do
        server.start!

        ::Wait.until_true!(description: "server pid created") { pid_file_exists? }
      end

      it "creates a log file capturing the stdout and stderr of the server in the configured log directory" do
        server.start!

        ::Wait.until_true!(description: "log file is created") do
          File.exists?("#{log_dir}/#{name}_console.log")
        end
      end

      it "logs that the server started on the configured port" do
        expect(logger).to receive(:info).with(/started on #{host}:#{port}/)

        server.start!
      end

      context "and a ping_uri is configured" do

        let(:additional_server_args) { { ping_uri: "/ping" } }

        let(:ping_count_endpoint) { URI("http://#{host}:#{port}/ping_count") }

        it "requests the configured ping uri when determining if the server is running" do
          server.start!

          expect(Net::HTTP.get(ping_count_endpoint)).to eql("1")
        end

      end

    end

    context "when the server is already running" do

      before(:example) do
        server.start!
        wait_until_started!
      end

      it "logs that the server is already running on the configured port" do
        expect(logger).to receive(:info).with(/already running on #{host}:#{port}/)

        server.start!
      end

    end

  end

  describe "#stop!" do

    context "when the server is running" do

      before(:example) { force_start! }

      after(:example) { force_stop! } # Ensure server has completely stopped

      it "stops the server" do
        server.stop!

        wait_until_stopped!
      end

      it "deletes the servers pid file" do
        server.stop!

        ::Wait.until_false!(description: "server pid is deleted") do
          File.exists?("#{pid_dir}/#{name}.pid")
        end
      end

      it "logs that the server has stopped" do
        expect(logger).to receive(:info).with(/stopped/)

        server.stop!
      end

    end

    context "when the server is not running" do

      it "logs that the server is not running" do
        expect(logger).to receive(:info).with(/not running/)

        server.stop!
      end

    end

  end

  describe "#status" do

    context "when the server is running" do

      before(:example) { force_start! }

      after(:example) { force_stop! }

      context "and the pid file exists" do

        it "returns :started" do
          expect(server.status).to eql(:started)
        end

      end

      context "and the pid file does not exist" do

        before(:example) { force_pid_file_deletion! }

        after(:example) { restore_pid_file! }

        it "returns :started" do
          expect(server.status).to eql(:started)
        end

      end

    end

    context "when the server is not running" do

      context "and the pid file does not exist" do

        it "returns :stopped" do
          expect(server.status).to eql(:stopped)
        end

      end

      context "and the pid file exists" do

        before(:example) { force_pid_file_creation! }

        after(:example) { force_pid_file_deletion! }

        it "returns :stopped" do
          expect(server.status).to eql(:stopped)
        end

      end

    end

  end

  describe "#to_s" do

    it "returns a string containing the servers name" do
      expect(server.to_s).to match(name)
    end

    it "returns a string containing the servers host" do
      expect(server.to_s).to match(host)
    end

    it "returns a string containing the servers port" do
      expect(server.to_s).to match(port.to_s)
    end

  end

end
