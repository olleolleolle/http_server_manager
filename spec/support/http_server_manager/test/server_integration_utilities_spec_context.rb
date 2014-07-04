shared_context "managed http server integration utilities" do
  include HttpServerManager::Test::ServerIntegrationUtilities

  before(:each) do
    allow(HttpServerManager.logger).to receive(:info)

    ensure_pid_file_backup_directory_exists!
  end

end
