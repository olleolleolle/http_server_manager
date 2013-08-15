shared_context "managed http server integration utilities" do
  include HttpServerManager::Test::ServerIntegrationUtilities

  before(:each) do
    HttpServerManager.logger.stub(:info)

    ensure_pid_file_backup_directory_exists!
  end

end
