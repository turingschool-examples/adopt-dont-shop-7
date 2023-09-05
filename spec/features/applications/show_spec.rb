require "rails_helper"

RSpec.describe "Application Show", type: :feature do
  describe "as a visitor" do
    describe "when I visit an applications show page" do
      it "then I can see the name, the full address of the applicant including street address, city, state, and zip code, description of why the applicant says they'd be a good home for this pet(s), names of all pets that this application is for (all names of pets should be links to their show page), and The Application's status, either 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
        application = Application.create!(
          name: "John Smith",
          street_address: "1234 Lane Street",
          city: "Happy City",
          state: "CO",
          zip_code: "80111",
          description: "I want an animal",
          status: "Accepted"
        )

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

        ApplicationPet.create!(pet: pet_1, application: application)

        visit "/applications/#{application.id}"

        expect(page).to have_content("#{application.name}")
        expect(page).to have_content("Street Address: #{application.street_address}")
        expect(page).to have_content("City: #{application.city}")
        expect(page).to have_content("State: #{application.state}")
        expect(page).to have_content("Zip Code: #{application.zip_code}")
        expect(page).to have_content("Description: #{application.description}")
        expect(page).to have_content("Pets: #{application.pets.first.name}")
        expect(page).to have_content("Status: #{application.status}")
      end
    end
  end

  describe "As a visitor when I visit an application's show page" do
    describe "And that application has not been submitted, then I see a section on the page to 'Add a Pet to this Application'" do
      describe "In that section I see an input where I can search for Pets by name" do
        describe "When I fill in this field with a Pet's name and I click submit," do
          it "Then I am taken back to the application show page and under the search bar I see any Pet whose name matches my search" do
            application = Application.create!(
              name: "John Smith",
              street_address: "1234 Lane Street",
              city: "Happy City",
              state: "CO",
              zip_code: "80111",
              description: "I want an animal",
              status: "Accepted"
            )

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

            visit "/applications/#{application.id}"

            expect(page).to have_content("Add a Pet to this Application")

            fill_in "Search for pets by name", with: "Cheesecake"

            click_button "Submit"

            expect(current_path).to eq("/applications/#{application.id}")

            expect(page).to have_content("Cheesecake")
          end
        end
      end
    end
  end
end
