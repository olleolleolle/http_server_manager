describe HttpServerManager::Server do
  include_context "server integration utilities"

  let(:server) { RackServer.new(port: 4001) }

  describe "#start!" do

    after(:each) { force_stop! }

    describe "when the server is not running" do

      after(:each) { wait_until_started! } # Ensure server has completely started

      it "should start the server via the provided command" do
        server.start!

        wait_until_started!
      end

      it "should create a pid file for the server in the configured pid directory" do
        server.start!

        ::Wait.until_true!("rack server pid created") { pid_file_exists? }
      end

      it "should create a log file capturing the stdout and stderr of the server in the configured log directory" do
        server.start!

        ::Wait.until_true!("log file is created") do
          File.exists?("#{log_dir}/rack_server_console.log")
        end
      end

      it "should log that the server started on the configured port" do
        logger.should_receive(:info).with(/started on port 4001/)

        server.start!
      end

    end

    describe "when the server is already running" do

      before(:each) do
        server.start!
        wait_until_started!
      end

      it "should log that the server is already running on the configured port" do
        logger.should_receive(:info).with(/already running on port 4001/)

        server.start!
      end

    end

  end

  describe "#stop!" do

    describe "when the server is running" do

      before(:each) { force_start! }

      after(:each) { force_stop! } # Ensure server has completely stopped

      it "should stop the server" do
        server.stop!

        wait_until_stopped!
      end

      it "should delete the servers pid file" do
        server.stop!

        ::Wait.until_false!("rack server pid is deleted") do
          File.exists?("#{pid_dir}/rack_server.pid")
        end
      end

      it "should log that the server has stopped" do
        logger.should_receive(:info).with(/stopped/)

        server.stop!
      end

    end

    describe "when the server is not running" do

      it "should log that the server is not running" do
        logger.should_receive(:info).with(/not running/)

        server.stop!
      end

    end

  end

  describe "#status" do

    describe "when the server is running" do

      before(:each) { force_start! }

      after(:each) { force_stop! }

      describe "and the pid file exists" do

        it "should return :started" do
          server.status.should eql(:started)
        end

      end

      describe "and the pid file does not exist" do

        before(:each) { force_pid_file_deletion! }

        after(:each) { restore_pid_file! }

        it "should return :started" do
          server.status.should eql(:started)
        end

      end

    end

    describe "when the server is not running" do

      describe "and the pid file does not exist" do

        it "should return :stopped" do
          server.status.should eql(:stopped)
        end

      end

      describe "and the pid file exists" do

        before(:each) { force_pid_file_creation! }

        after(:each) { force_pid_file_deletion! }

        it "should return :stopped" do
          server.status.should eql(:stopped)
        end

      end

    end

  end

  describe "#to_s" do

    it "should return a string containing the servers name" do
      server.to_s.should match(/rack_server/)
    end

    it "should return a string containing the servers port" do
      server.to_s.should match(/4001/)
    end

  end

end
