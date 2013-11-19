describe "server_integration_examples" do

  let(:server) { RackServer.new(name: "test_server", host: "localhost", port: 4001) }

  it_should_behave_like "a managed http server"

end
