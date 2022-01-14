require "spec_helper"

RSpec.describe Velocity::Team, :vcr do
  describe ".all" do
    subject(:result) { described_class.all }

    it "load all teams" do
      expect(result.size).to eq(4)
      expect(result.map(&:name)).to match_array(["Quality", "Velocity", "los-teros", "Neo"])
    end
  end
end
