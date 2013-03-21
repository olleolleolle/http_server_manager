describe HttpServerManager::Rake::ServerTasks do
  include_context "managed http server integration utilities"
  include ::Rake::DSL

  before(:all) do
    namespace :rack_server do
      server_tasks
    end
  end

  describe "start task" do

    let(:task) { ::Rake::Task["rack_server:start"] }

    after(:each) { force_stop! }

    it "should start a stopped server" do
      task.execute

      wait_until_started!
    end

  end

  describe "stop task" do

    let(:task) { ::Rake::Task["rack_server:stop"] }

    before(:each) { force_start! }

    after(:each) { force_stop! } # Ensure server has completely stopped

    it "should stop a started server" do
      task.execute

      wait_until_stopped!
    end

  end

  describe "status task" do

    let(:task) { ::Rake::Task["rack_server:status"] }

    it "should write the server name and it's status to stdout" do
      server_tasks.should_receive(:puts).with("rack_server is stopped")

      task.execute
    end

  end

  def server_tasks
    @server_tasks ||= HttpServerManager::Rake::ServerTasks.new(server)
  end

  def server
    @server ||= RackServer.new(port: 4001)
  end

end
