require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "search_pets_by_name" do
    it 'returns pets that match the search tearm' do

      victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      pet_3 = shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

      results = victor_app.search_pets_by_name("Mr. Pirate")
      results_2 = victor_app.search_pets_by_name("clawdia")
      results_3 = victor_app.search_pets_by_name("cLaWdIa")

      expect(results).to include(pet_1)
      expect(results_2).to include(pet_2)
      expect(results_3).to include(pet_2)
      expect(results).not_to include(pet_2)
      expect(results).not_to include(pet_3)
    end
  end

  describe 'adopt_pet' do
    it 'associates a pet with the application' do

      victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      pet_3 = shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

      victor_app.adopt_pet(pet_1.id)

      expect(victor_app.pets).to include(pet_1)
    end
  end
end