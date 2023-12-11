require "rails_helper"

RSpec.describe "Admin approves a Pet for Adoption and it does not effect other applications" do
  it "Admin visits application show page and approves a pet and visits another application" do

    victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    victor_app.pets << pet_1

    sam_app = Application.create!(applicant_name: "Sam Puttman", address: "840 Townhouse Ln", city: "Hazelwood", state: "MO", zip_code: "63042", description: "Because I love cats!")
    sam_app.pets << pet_1
    
    
    #When I visit an admin application show page ('/admin/applications/:id')
    #When I visit the admin application show page for one of the applications
    visit "/admin/applications/#{victor_app.id}"

    #And I approve or reject the pet for that application
    expect(page).to have_content("Approve")
    within("div#pet_#{pet_1.id}") do
      click_button "Approve"
    end
    
    #When I visit the other application's admin show page
    visit "/admin/applications/#{sam_app.id}"
    #Then I do not see that the pet has been accepted or rejected for that application
    #And instead I see buttons to approve or reject the pet for this specific application
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")

  end
end