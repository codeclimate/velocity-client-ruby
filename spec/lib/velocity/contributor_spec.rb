require 'spec_helper'

RSpec.describe Velocity::Contributor do
  describe ".where" do
    context "performs a request that" do
      before { set_api_token }

      it "filters by name" do
        result = described_class.where(name: "vera protopopova")
        expect(result.size).to eq(2)

        expect(result.first.name).to eq("Vera Protopopova")
        expect(result.first.email).to eq("vera@codeclimate.com")

        expect(result.last.name).to eq("Vera Protopopova")
        expect(result.last.email).to eq("vera.protopopova@gmail.com")
      end

      it "filters by email" do
        result = described_class.where(email: "vera@codeclimate.com")
        expect(result.size).to eq(1)

        expect(result.first.name).to eq("Vera Protopopova")
        expect(result.first.email).to eq("vera@codeclimate.com")
      end

      context "filters by name and email" do
        it "returns a result if both values exist" do
          result = described_class.where(email: "vera@codeclimate.com", name: "Vera Protopopova")
          expect(result.size).to eq(1)

          expect(result.first.name).to eq("Vera Protopopova")
          expect(result.first.email).to eq("vera@codeclimate.com")
        end

        it "won't return filtered contributor if email and name dont match" do
          result = described_class.where(email: "vera@codeclsadfimate.com", name: "Vera Protopopova")
          expect(result.size).to eq(0)
        end
      end
    end
  end
end
