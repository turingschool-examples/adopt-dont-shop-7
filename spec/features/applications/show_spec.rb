require "rails_helper"

RSpec.describe "Application Show",type: :feature do
  describe "as a visitor" do
    describe "when I visit an applications show page" do
      it "then I can see the name, the full address of the applicant including street address, city, state, and zip code, description of why the applicant says they'd be a good home for this pet(s), names of all pets that this application is for (all names of pets should be links to their show page), and The Application's status, either 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
        shelter = Shelter.create!(
          foster_program: true,
          name: "The Shelter",
          city: "Happy City",
          rank: 1
        )

        pet_1 = shelter.pets.create!(
          adoptable: true,
          age: 3,
          breed: "orange cat",
          name: "Cheesecake"
        )

        application = Application.create!(
          name: "John Smith",
          address: "1234 Lane Street, Happy City, CO, 80111",
          description: "I want an animal",
          pets: [pet_1],
          status: "Accepted"
        )

        visit "/applications/#{application.id}"

        expect(page).to have_content("#{application.name}")
        expect(page).to have_content("Address: #{application.address}")
        expect(page).to have_content("Description: #{application.description}")
        expect(page).to have_content("Pets: #{application.pets.first.name}") 
        expect(page).to have_content("Status: #{application.status}")
      end
    end
  end
end