describe HttpServerManager::Server do

  class HttpServerManager::TestableServer < HttpServerManager::Server

    def start_command
      "some command"
    end

  end

  let(:server_options) { { name: "Test Server", host: "localhost", port: 8888 } }

  let(:server) { HttpServerManager::TestableServer.new(server_options) }

  describe "#start!" do

    before(:each) { allow(Wait).to receive(:until_true!) }

    context "when the server is not running" do

      let(:env_timeout) { nil }

      before(:each) do
        allow(ENV).to receive(:[]).with("timeout").and_return(env_timeout)
        allow(server).to receive(:running?).and_return(false)
        allow(Process).to receive(:spawn)
      end

      it "should start the server by spawning a process that executes the start command" do
        expect(Process).to receive(:spawn).with("some command", anything).and_return(888)

        server.start!
      end

      context "when a timeout is provided as a constructor argument" do

        let(:server_options) { { name: "Test Server", host: "localhost", port: 8888, timeout_in_seconds: 3 } }

        it "should wait for the specified amount of time in seconds for the server to start" do
          expect(Wait).to receive(:until_true!).with(anything, timeout_in_seconds: 3)

          server.start!
        end

      end

      context "when a timeout is provided as an environment variable" do

        let(:env_timeout) { "8" }

        it "should wait for the specified amount of time in seconds for the server to start" do
          expect(Wait).to receive(:until_true!).with(anything, timeout_in_seconds: 8)

          server.start!
        end

      end

      context "when no timeout is provided" do

        it "should wait 20 seconds for the server to start" do
          expect(Wait).to receive(:until_true!).with(anything, timeout_in_seconds: 20)

          server.start!
        end

      end

    end

  end

  describe "#restart!" do

    before(:each) do
      allow(server).to receive(:start!)
      allow(server).to receive(:stop!)
    end

    it "should first stop the server and then start the server" do
      expect(server).to receive(:stop!).ordered
      expect(server).to receive(:start!).ordered

      server.restart!
    end

  end

end
