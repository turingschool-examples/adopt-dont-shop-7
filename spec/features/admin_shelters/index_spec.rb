require "rails_helper"

RSpec.describe "the application show" do
  it "displays all shelters in the system in reverse alphabetical order" do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora Co", foster_program: false, rank: 3)
    shelter_2 = Shelter.create!(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 9)
    # 10. Admin Shelters Index
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    visit "admin/shelters"
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    expect("Denver shelter").to appear_before("Boulder shelter")
    expect("Boulder shelter").to appear_before("Aurora shelter")
  end
  
  it "displays shelters with at least one pending application" do
    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", application_status: "Pending",description: "Because I'm rich! :)")
    sam_app = Application.create!(applicant_name: "Sam Puttman", address: "94 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401",application_status: "Pending", description: "Because I'm super rich! :)")
    natalie_app = Application.create!(applicant_name: "Natalie Lan", address: "96 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm super deduperdy rich! :)")
  
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 3)
    shelter_2 = Shelter.create!(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 9)
  
    pet_1 = shelter_1.pets.create!(name: "Roxy", breed: "labrador", age: 7, adoptable: true)
    pet_2 = shelter_2.pets.create!(name: "Rocky", breed: "dalmation", age: 4, adoptable: true) 
    pet_3 = shelter_3.pets.create!(name: "Brownie", breed: "ewok", age: 12, adoptable: true)
  
    victor_app.pets << pet_1
    sam_app.pets << pet_2
    natalie_app.pets << pet_3
  
    # 11. Shelters with Pending Applications
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    visit "/admin/shelters"
    # Then I see a section for "Shelters with Pending Applications"
    expect(page).to have_content("Shelters with Pending Applications")
    # And in this section I see the name of every shelter that has a pending application
    within("div#pending_applications") do
      expect(page).to have_content("Aurora shelter")
      expect(page).to have_content("Denver shelter")
      expect(page).to_not have_content("Boulder shelter")
    end
  end
end