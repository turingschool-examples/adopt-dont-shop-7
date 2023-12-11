require "rails_helper"

RSpec.describe "Admin Rejects a Pet for Adoption" do
  it "Admin visits application show page and approves a pet" do

    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    victor_app.pets << pet_1
  
    #When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{victor_app.id}"

    #For every pet that the application is for, I see a button to reject the application for that specific pet
    expect(page).to have_content("Reject")
    
    #When I click that button
    within("div#pet_#{pet_1.id}") do
      click_button "Reject"
    end
    
    #Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/applications/#{victor_app.id}")
    #And next to the pet that I rejected, I do not see a button to approve or reject this pet
    expect(page).not_to have_button("Reject")
    #And instead I see an indicator next to the pet that they have been rejected
    expect(page).to have_content("Rejected")
  end
end