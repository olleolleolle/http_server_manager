describe HttpServerManager::StdOutLogger do

  let(:logger) { HttpServerManager::StdOutLogger.new }

  describe "#info" do

    it "should write the message to stdout" do
      message = "Some message"
      expect(logger).to receive(:puts).with(message)

      logger.info message
    end

  end

end
