describe HttpServerManager::Server do

  class HttpServerManager::TestableServer < HttpServerManager::Server

    def start_command
      "some command"
    end

  end

  let(:server) { HttpServerManager::TestableServer.new(name: "Test Server", port: 8888) }

  before(:each) do
    server.stub!(:start!)
    server.stub!(:stop!)
  end

  describe "#restart!" do

    it "should first stop the server and then start the server" do
      server.should_receive(:stop!).ordered
      server.should_receive(:start!).ordered

      server.restart!
    end

  end

end
