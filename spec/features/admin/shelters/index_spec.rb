require 'rails_helper'

RSpec.describe 'admin shelter index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
    @shel_1 = Shelter.create(name: "C. Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shel_2 = Shelter.create(name: "B. RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shel_3 = Shelter.create(name: "A. Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shel_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shel_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shel_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
    @app_2 = Application.create!(name: "Jim", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 1)

    PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    PetApp.create!(application_id: @app_2.id, pet_id: @pet_3.id)
    end

    # SQL Only Story
    # 10. Admin Shelters Index
    it 'lists all shelters in reverse alpha order' do
      # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
      # When I visit the admin shelter index ('/admin/shelters')
      visit '/admin/shelters'
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect(@shel_1.name).to appear_before(@shel_2.name)
      expect(@shel_1.name).to appear_before(@shel_3.name)
      
      expect(@shel_2.name).to appear_before(@shel_3.name)
      expect(@shel_2.name).to_not appear_before(@shel_1.name)
      
      expect(@shel_3.name).to_not appear_before(@shel_1.name)
      expect(@shel_3.name).to_not appear_before(@shel_2.name)
    end

     # For this story, you should fully leverage ActiveRecord methods in your query.
    # 11. Shelters with Pending Applications
    it 'shows shelters with pending applications' do
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      # Then I see a section for "Shelters with Pending Applications"
      expect(page).to have_content("Shelters with Pending Applications")
      # And in this section I see the name of every shelter that has a pending application
      within '.pending-app' do
        expect(page).to have_content(@shel_3.name)
        expect(page).to_not have_content(@shel_1.name)
        expect(page).to_not have_content(@shel_2.name)
      end
    end
  end
end