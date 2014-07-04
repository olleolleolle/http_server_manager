describe HttpServerManager do

  describe ".logger" do

    describe "when no logger has been explicitly configured" do

      before(:each) { HttpServerManager.logger = nil }

      it "should default to the stdout logger" do
        expect(HttpServerManager.logger).to be_a(HttpServerManager::StdOutLogger)
      end

    end

    describe "when a logger has been explicitly configured" do

      let(:logger) { double("Logger").as_null_object }

      before(:each) { HttpServerManager.logger = logger }

      after(:each) { HttpServerManager.logger = nil }

      it "should return the configured logger" do
        expect(HttpServerManager.logger).to eql(logger)
      end

    end

  end

end
