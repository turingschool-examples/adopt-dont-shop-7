require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "Relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  
  describe "#matching_applications" do 
    it "checks for matching applications" do 
      application_1 = Application.create!(name: "John Doe", street_address: "123 Sesame St", city: "Denver", state: "CO", zip_code: "80202", description: "I have big hands.", application_status: "Pending")

      shelter = Shelter.create!(foster_program: true, name: "Home Shelter", city: "Denver", rank: 1)

      buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")

      pa1 = PetApplication.create!(application: application_1, pet: buddy)

      expect(PetApplication.matching_applications(application_1)).to eq([pa1])
  end
end
  
end