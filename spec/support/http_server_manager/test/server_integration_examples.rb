shared_examples_for "a managed http server" do
  include_context "managed http server integration utilities"

  it "is a HttpServerManager::Server" do
    expect(server).to be_an(HttpServerManager::Server)
  end

  describe "#start!" do

    after(:each) { force_stop! }

    it "starts the server via the provided command" do
      server.start!

      wait_until_started!
    end

  end

end
