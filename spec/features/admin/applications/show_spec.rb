require 'rails_helper'

RSpec.describe "Admin Index Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    @pet_2 = @shelter_1.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")
    @petapp_1 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id, status: "Pending")
    @petapp_2 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_2.id, status: "Pending")
    @petapp_3 = PetApplication.create!(application_id: @application_2.id, pet_id: @pet_1.id, status: "Pending")
    @petapp_4 = PetApplication.create!(application_id: @application_2.id, pet_id: @pet_2.id, status: "Pending")
  end

  # USER STORY 13
  xit "displays a rejection button that redirects to the same page and the pet is shown as rejected" do
    visit "/admin/applications/#{application.id}"

    within(@pet_1.id) do
      expect(page).to have_button("Reject Pet")
      click_button "Reject Pet"
    end

    within(@pet_1.id) do
      expect(page).to have_content("Pet status: Rejected")
    end
  end

  # USER STORY 14
  xit "approved/rejected pets on one application do not affect other applications" do

    visit "/admin/applications/#{@application_1.id}"

    within(@pet_1) do
      click_button("Reject")
      expect(page).to have_content("Rejected")
    end

    within(@pet_2) do
      click_button("Approve")
      expect(page).to have_content("Approved")
    end

    visit "/admin/applications/#{@application_2.id}"

    within(@pet_1) do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within(@pet_2) do
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end
