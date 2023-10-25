require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  end

  describe "User Story 10: Admin Shelters Index" do
    describe "In the admin shelter index, I see all Shelters in the system listed in reverse alphabetical order by name" do

      it "lists shelters in reverse alphabetical order" do
        visit "/admin/shelters"

        first = find("#shelter-#{@shelter_2.id}")
        middle = find("#shelter-#{@shelter_3.id}")
        last = find("#shelter-#{@shelter_1.id}")

        expect(first).to appear_before(middle)
        expect(middle).to appear_before(last)

        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content("Created at: #{@shelter_1.created_at}")
          expect(page).to have_link("Update #{@shelter_1.name}")
          expect(page).to have_link("Delete #{@shelter_1.name}")
        end

        within "#shelter-#{@shelter_2.id}" do
          expect(page).to have_content("Created at: #{@shelter_2.created_at}")
          expect(page).to have_link("Update #{@shelter_2.name}")
          expect(page).to have_link("Delete #{@shelter_2.name}")
        end

        within "#shelter-#{@shelter_3.id}" do
          expect(page).to have_content("Created at: #{@shelter_3.created_at}")
          expect(page).to have_link("Update #{@shelter_3.name}")
          expect(page).to have_link("Delete #{@shelter_3.name}")
        end
      end
    end
  end

#   For this story, you should fully leverage ActiveRecord methods in your query.

# 11. Shelters with Pending Applications

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelters with Pending Applications"
# And in this section I see the name of every shelter that has a pending application

  describe "User Story 11: Shelters with Pending Applications" do
    before(:each) do
      @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
    end

    describe "As a visitor, when I visit the admin shelter index" do
      it "I see a section that has the name of every shelter w/ pending applications" do
        visit "/admin/shelters"

        within "#shelterPendingApps" do
          expect(page).to have_content("Shelters with pending applications")
          expect(page).to_not have_content(@shelter.name)
        end

        visit "/applications/#{@application_1.id}"
        fill_in "Search", with: "Ba"
        click_on("Search")
        
        within "#pet-#{@pet_1.id}" do
          click_button("Adopt this Pet")
        end

        within "#appliedPets" do
          fill_in("add_qualifications", with: "I also have a dog named Lola who is a showgirl.")
          click_button("Submit")
        end

        expect(page).to have_content("Pending")
        visit "/admin/shelters"

        within "#shelterPendingApps" do
          expect(page).to have_content(@shelter.name)
        end
      end
    end
  end



end