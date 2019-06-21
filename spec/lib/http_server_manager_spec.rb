describe HttpServerManager do

  describe "::logger" do

    before(:example) { @initial_logger = HttpServerManager.logger }

    after(:example) { HttpServerManager.logger = @initial_logger }

    context "when no logger has been explicitly configured" do

      before(:example) { HttpServerManager.logger = nil }

      it "defaults to the stdout logger" do
        expect(HttpServerManager.logger).to be_a(HttpServerManager::StdOutLogger)
      end

    end

    context "when a logger has been explicitly configured" do

      let(:logger) { double("Logger").as_null_object }

      before(:example) { HttpServerManager.logger = logger }

      it "returns the configured logger" do
        expect(HttpServerManager.logger).to eql(logger)
      end

    end

  end

end
