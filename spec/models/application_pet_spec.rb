require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "status enums" do
    it "returns different results for different statuses" do
      expect(ApplicationPet.statuses).to eq({"Pending" => 0, "Accepted" => 1, "Rejected" => 2})
      expect(ApplicationPet.statuses[:Pending]).to eq(0)
      expect(ApplicationPet.statuses["Accepted"]).to eq(1)
      expect(ApplicationPet.statuses[:Rejected]).to eq(2)
      expect(ApplicationPet.statuses["Test"]).to eq(nil)
    end
  end
end