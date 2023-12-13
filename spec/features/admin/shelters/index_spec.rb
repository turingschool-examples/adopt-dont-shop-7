require 'rails_helper'

RSpec.describe 'the admin shelters index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      # Shelters
      @puppy_hope = Shelter.create!(name: 'Puppy Hope', city: 'Palo Alto',foster_program: true, rank: 1 )
      @the_farm = Shelter.create!(name: 'South Shannon Angus', city: 'Palo Alto',foster_program: true, rank: 1 )
      @walrus_haven = Shelter.create!(name: "Cicero's Walrus Emporium", city: 'Palo Alto',foster_program: true, rank: 1 )
      # Pets
      @pet_1 = Pet.create!(name: 'Sparky', age: 4, breed: 'Chihuahua', adoptable: true, shelter_id: @puppy_hope.id )
      @pet_2 = Pet.create!(name: 'Spot', age: 1, breed: 'Angus', adoptable: true, shelter_id: @puppy_hope.id )
      @pet_3 = Pet.create!(name: 'Spotty', age: 10, breed: 'Walrus', adoptable: true, shelter_id: @puppy_hope.id )
      # Applications 
      @app_1 = Application.create!(name: 'Megan Samuels', street_address: '505 E. Happy Pl', city: "Austin", state: "MN", zip: "55912", description: 'I love dogs', status: 0)
      # Pet Applications 
      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    end

    # 10. Admin Shelters Index (SQL Only Story)
    it "orders all shelters in system in reverse alphabetical order by name" do 
      # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect(@walrus_haven.name).to_not appear_before(@puppy_hope.name)
      expect(@walrus_haven.name).to_not appear_before(@the_farm.name)
      expect(@puppy_hope.name).to appear_before(@walrus_haven.name)
      expect(@the_farm.name).to appear_before(@walrus_haven.name)
      
      expect(@puppy_hope.name).to_not appear_before(@the_farm.name)
      
      expect(@the_farm.name).to appear_before(@walrus_haven.name)
      expect(@the_farm.name).to appear_before(@puppy_hope.name)
    end
  end 
end


