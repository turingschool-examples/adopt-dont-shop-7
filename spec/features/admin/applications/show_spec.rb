require "rails_helper"

RSpec.describe "admin application show page" do

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, 
# I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, 
# I do not see a button to approve this pet
# And instead I see an indicator next to the pet 
# that they have been approved
  describe "when i visit admin application show page" do
    describe "for every pet for the application" do
      it "displays a button to approve the application for that specific pet" do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
        scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
        application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "Pending")

        application_1.pets << scrappy

        visit "admin/applications/#{application_1.id}"
        
        expect(page).to have_button("Approve")
      end
      
      it "removes the 'Approve' button when clicked and shows the pet has been approved" do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
        application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "Pending")
        
        application_1.pets << scrappy
        visit "admin/applications/#{application_1.id}"
        save_and_open_page
        click_button "Approve"

        expect(page).to_not have_button("Approve")
        expect(page).to have_content("Approved")


      end
    end
  end

end