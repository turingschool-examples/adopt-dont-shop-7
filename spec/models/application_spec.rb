require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street_address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :description}    
  end

  describe 'enum' do 
    it "has an enum for status" do 
      # shel_1 = Shelter.create!(name: "Dog's Home", city: "Gustine", foster_program: true, rank: 1)
      # pet_1 = Shelter.pets.create!(name: "Cito", age: 4, breed: "Lab", adoptable: true)
      app_1 = Application.create!(name: "0", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
      app_2 = Application.create!(name: "1", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 1)
      app_3 = Application.create!(name: "2", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 2)
      app_4 = Application.create!(name: "3", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 3)
      
      expect(app_1.status).to eq("In Progress")
      expect(app_2.status).to eq("Pending")
      expect(app_3.status).to eq("Accepted")
      expect(app_4.status).to eq("Rejected")
    end
  end 

  describe 'relationships' do
    it {should have_many :pet_apps}
    it {should have_many(:pets).through(:pet_apps)}
  end

  describe 'instance methods' do
  end
end