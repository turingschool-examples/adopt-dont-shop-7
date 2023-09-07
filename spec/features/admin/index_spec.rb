require "rails_helper"

RSpec.describe "Admin Shelter Index", type: :feature do
  describe "as a visitor" do
    describe "when I visit the admin shelter index ('/admin/shelters/)" do
      it "I see all shelters in the system listed in reverse alphabetical order by name" do
        shelter_1 = Shelter.create!(
          foster_program: true,
          name: "The Shelter",
          city: "Happy City",
          rank: 1
        )
        shelter_2 = Shelter.create!(
          foster_program: true,
          name: "City Shelter",
          city: "Sad City",
          rank: 1
        )
        shelter_2 = Shelter.create!(
          foster_program: true,
          name: "Zoo Shelter",
          city: "Zoo City",
          rank: 1
        )

        visit "/admin/shelters"

        expect(page).to have_content("The Shelter")
        expect(page).to have_content("City Shelter")
        expect(page).to have_content("Zoo Shelter")

        expect("Zoo Shelter").to appear_before("The Shelter")
        expect("The Shelter").to appear_before("City Shelter")
      end
    end
  end

  describe "as a visitor" do
    describe "when I visit the admin shelter index ('/admin/shelters')" do
      describe "then I see a section for 'Shelters with Pending Applications'" do
        it "and In this section I see the name of every shelter that has a pending application" do
          shelter = Shelter.create!(
            foster_program: true,
            name: "The Shelter",
            city: "Happy City",
            rank: 1
          )

          shelter_2 = Shelter.create!(
            foster_program: false,
            name: "A Shelter",
            city: "A City",
            rank: 5
          )

          pet_1 = shelter.pets.create!(
            adoptable: true,
            age: 3,
            breed: "orange cat",
            name: "Cheesecake"
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

          application.pets << pet_1

          visit "/admin/shelters"

          expect(page).to have_content("Shelters with Pending Applications")

          within("#pending-applications") do
            expect(page).to have_content("The Shelter")
            expect(page).not_to have_content("A Shelter")
          end
        end
      end
    end
  end
end
