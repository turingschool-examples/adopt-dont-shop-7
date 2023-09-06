equire "rails_helper"

RSpec.feature "Admin Application Show", type: :feature do
  describe "When I visit an admin application show page, for every pet that the application is for, I see a button to approve the application for that specific pet" do
    describe "When I click that button then I'm taken back to the admin application show page" do
      it "Next to the pet that I approved, I do not see a button to approve this pet instead I see an indicator next to the pet that they have been approved" do
        shelter = Shelter.create!(
          foster_program: true,
          name: "The Shelter",
          city: "Happy City",
          rank: 1
        )

        pet_1 = shelter.pets.create!(
          adoptable: true,
          age: 7,
          breed: "sphynx",
          name: "Bare-y Manilow",
          shelter_id: shelter.id
        )

        pet_2 = shelter.pets.create!(
          adoptable: true,
          age: 3,
          breed: "domestic pig",
          name: "Babe",
          shelter_id: shelter.id
        )

        pet_3 = shelter.pets.create!(
          adoptable: true,
          age: 4,
          breed: "chihuahua",
          name: "Elle",
          shelter_id: shelter.id
        )

        application = Application.create!(
          name: "John Smith",
          street_address: "1234 Lane Street",
          city: "Happy City",
          state: "CO",
          zip_code: "80111",
          owner_description: "I want an animal",
          status: "Pending"
        )

        application.pets << pets

        visit "/admin/applications/#{applcation.id}"

        pets.each do |pet|
          expect(page).to have_button("Approve #{pet.name}")
          click_button("Approve #{pet.name}")

          expect(page).to have_no_button("Approve #{pet.name}")
          expect(page).to have_content("#{pet.name} has been approved")
        end
      end
    end
  end
end
