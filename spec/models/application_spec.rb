require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:description) }
  end
  it "should change status" do
    application = Application.create!(name: "Barry", street_address: "1234 Oxford St", city: "OKC", state: "OK", zipcode: "73122", description: "I love animals!",application_status: "in progress")
    expect(application.application_status).to eq("in progress")
    application.pending
    expect(application.application_status).to eq("Pending")
  end 
end