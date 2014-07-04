describe HttpServerManager::Rake::ServerTasks do
  include_context "managed http server integration utilities"
  include ::Rake::DSL

  let(:task_namespace) { :test_server_namespace }
  let(:task_scope) { double("TaskScope", path: task_namespace) }
  let(:server) { double(HttpServerManager::Server, name: "test_server") }

  let(:server_tasks) { HttpServerManager::Rake::ServerTasks.new(server) }

  before(:each) do
    namespace task_namespace do
      server_tasks
    end
  end

  after(:each) { Rake.application.tasks_in_scope(task_scope).each(&:clear) }

  describe "start task" do

    let(:task) { ::Rake::Task["#{task_namespace}:start"] }

    it "should start the server" do
      expect(server).to receive(:start!)

      task.execute
    end

  end

  describe "stop task" do

    let(:task) { ::Rake::Task["#{task_namespace}:stop"] }

    it "should stop the server" do
      expect(server).to receive(:stop!)

      task.execute
    end

  end

  describe "restart task" do

    let(:task) { ::Rake::Task["#{task_namespace}:restart"] }

    it "should restart the server" do
      expect(server).to receive(:restart!)
      task.execute
    end

  end

  describe "status task" do

    let(:task) { ::Rake::Task["#{task_namespace}:status"] }

    it "should write the server name and it's status to stdout" do
      allow(server).to receive(:status).and_return("stopped")
      expect(server_tasks).to receive(:puts).with("test_server is stopped")

      task.execute
    end

  end

end
