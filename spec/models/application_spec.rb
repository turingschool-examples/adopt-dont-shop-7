require "rails_helper"

RSpec.describe Application, type: :model do 
  describe "relationships" do 
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe "model method" do 
    it 'gives you a string address' do
      application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")

      expect(application1.address).to eq("1234 Sugarwood Cir, Newport, Kentucky 41071")
    end
  end
end
