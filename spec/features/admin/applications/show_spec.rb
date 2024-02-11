require 'rails_helper'

RSpec.describe 'Admin Application Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @shel_1 = Shelter.create!(name: "Dog's Home", city: "Gustine", foster_program: true, rank: 1)
      @shel_2 = Shelter.create!(name: "Cat's Home", city: "Gustine", foster_program: true, rank: 1)

      @pet_1 = @shel_1.pets.create!(name: "Cito", age: 4, breed: "Lab", adoptable: true)
      @pet_2 = @shel_1.pets.create!(name: "Charmander", age: 4, breed: "fire", adoptable: true)
      @pet_3 = @shel_1.pets.create!(name: "Char", age: 4, breed: "fire", adoptable: true)

      @app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
      @app_2 = Application.create!(name: "Jim", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 1)

      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
      PetApp.create!(application_id: @app_2.id, pet_id: @pet_3.id)
    end
  end
end 