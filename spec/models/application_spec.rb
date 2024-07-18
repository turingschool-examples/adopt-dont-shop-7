require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_applications)}
    it { should have_many(:pets).through(:pet_applications) }
  end
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    end

  describe "instance methods" do
    it "has_pets?" do
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: shelter.id)
      pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: shelter.id)
      app1 = Application.create!(name: "Shaggy",
                                street_address: "1234 Bobs rd",
                                city: "Denver",
                                state: "Colorado",
                                zip_code: "80220",
                                description: "I want a dog!",
                                status: "In Progress")
      app2 = Application.create!(name: "Fred",
                                street_address: "1234 Fred rd",
                                city: "Boulder",
                                state: "Colorado",
                                zip_code: "80221",
                                description: "I NEED a dog!",
                                status: "In Progress")
      PetApplication.create!(application: app1, pet: pet1)
      PetApplication.create!(application: app1, pet: pet2) 
      
      expect(app1.has_pets?).to be true
      expect(app2.has_pets?).to be false
    end
  end
end