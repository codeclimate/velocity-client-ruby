require "spec_helper"

RSpec.describe Velocity::Invite, :vcr do
  describe ".create" do
    subject(:result) do
      described_class.create(
        name: "Victor A.",
        email: "vantoniazzi+1@codeclimate.com",
        job_function: "Software Engineer",
        role_ids: [2],
      )
    end

    it "send an invite" do
      expect(result).to be_a(Velocity::Invite)
      expect(result.id).to eq("39655")
    end
  end
end
