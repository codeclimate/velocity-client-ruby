require "spec_helper"

RSpec.describe Velocity::Role, :vcr do
  describe ".all" do
    subject(:result) { described_class.all }

    it "load all roles" do
      expect(result.size).to eq(26)
      expect(result.map(&:name)).to include("Administrator", "Engineer", "+ Workstreams")
    end
  end
end
