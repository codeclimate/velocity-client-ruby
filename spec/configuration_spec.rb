require "spec_helper"

RSpec.describe Velocity do
  context "store the configuration for the entire application" do
    before do
      Velocity.configure do |config|
        config.api_token = "new-token"
      end
    end

    it "returns the correct api_token" do
      expect(Velocity.configuration.api_token).to eq("new-token")
    end
  end
end
