require 'rails_helper'

RSpec.describe Application, type: :model do 

  describe "relationships" do 
    it { should have_many(:pets) }
    it { should have_many(:pets).through(:application_pets)}
  end

  describe "pending_shelters_application" do
    it "returns all applications with a status of pending" do
      expect(Application.pending_shelters_application).to eq(Application.where(status: "Pending"))
    end
  end
end