describe HttpServerManager::StdOutLogger do

  let(:logger) { HttpServerManager::StdOutLogger.new }

  describe "#info" do

    it "should write the message to stdout" do
      message = "Some message"
      logger.should_receive(:puts).with(message)

      logger.info message
    end

  end

end
