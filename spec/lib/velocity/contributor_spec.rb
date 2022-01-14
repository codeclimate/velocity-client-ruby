require 'spec_helper'

RSpec.describe Velocity::Contributor, :vcr do
  describe ".where" do
    subject(:result) { described_class.where(search) }

    context "filters by name" do
      let(:search) { { name: "vera protopopova" } }

      it do
        expect(result.size).to eq(1)
        expect(result.first.name).to eq("Vera Protopopova")
        expect(result.first.email).to eq("vera@codeclimate.com")
      end
    end

    context "filters by email" do
      let(:search) { { email: "vera@codeclimate.com" } }

      it do
        expect(result.size).to eq(1)
        expect(result.first.name).to eq("Vera Protopopova")
        expect(result.first.email).to eq("vera@codeclimate.com")
      end
    end

    context "filters by name and email" do
      let(:search) { { email: "vera@codeclimate.com", name: "Vera Protopopova" } }

      it do
        expect(result.size).to eq(1)
        expect(result.first.name).to eq("Vera Protopopova")
        expect(result.first.email).to eq("vera@codeclimate.com")
      end

      describe "won't return filtered contributor if email and name dont match" do
        let(:search) { { email: "vera@testcompany.com", name: "Vera Protopopova" } }

        it do
          expect(result.size).to eq(0)
        end
      end
    end
  end
end
