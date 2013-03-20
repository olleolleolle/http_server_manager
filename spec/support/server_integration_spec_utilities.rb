shared_context "server integration specification utilities" do
  include HttpServerManager::ServerIntegrationTestSupport

  before(:each) do
    HttpServerManager.logger.stub!(:info)

    ensure_pid_file_backup_directory_exists!
  end

end
