require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pets).through(:application_pets) }
    it { should have_many(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should  validate_presence_of(:description) }
  end

  describe "instance methods" do
    let!(:application_1) {Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.")}

    it "submit reason for adoption" do
      expect(application_1.status).to eq("in_progress")

      application_1.submit_reason_for_adoption("the best reason")
      expect(application_1.status).to eq("pending")
    end
  end
end
