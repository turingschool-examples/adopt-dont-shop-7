require 'rails_helper'

RSpec.feature "Admin Approves a Pet for Adoption", type: :feature do
  scenario "Admin visits application show page and approves a pet" do

    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    victor_app.pets << pet_1
  
    #When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{victor_app.id}"

    #For every pet that the application is for, I see a button to approve the application for that specific pet
    expect(page).to have_content("Approve")
    
    #When I click that button
    within("div#pet_#{pet_1.id}") do
      click_button "Approve"
    end
    
    #Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/applications/#{victor_app.id}")
    #And next to the pet that I approved, I do not see a button to approve this pet
    expect(page).not_to have_button("Approve")
    #And instead I see an indicator next to the pet that they have been approved
    expect(page).to have_content("Approved")
  end
end