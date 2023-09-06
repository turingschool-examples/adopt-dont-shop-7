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
          owner_description: "I want an animal",
          status: "In Progress"
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
        expect(page).to have_content("Description: #{application.owner_description}")
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
              owner_description: "I want an animal",
              status: "In Progress"
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
  describe "as a visitor" do
    describe "when I visit an application's show page and I search for a pet by name, and I see the names of Pets that match my search" do
      describe "then next to each Pet's name I see a button to 'Adopt this Pet'" do
        describe "when I click one of these buttons" do
          it "I am taken back to the application show page and I see the pet I want to adopt listed on this application" do
            application = Application.create!(
              name: "John Smith",
              street_address: "1234 Lane Street",
              city: "Happy City",
              state: "CO",
              zip_code: "80111",
              owner_description: "I want an animal",
              status: "In Progress"
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

            fill_in "Search for pets by name", with: "Cheesecake"

            click_button "Submit"

            expect(page).to have_content("Cheesecake")
            expect(page).to have_button("Adopt this Pet")

            click_button "Adopt this Pet"

            expect(current_path).to eq("/applications/#{application.id}")

            within("#pets") do
              expect(page).to have_content("Cheesecake")
            end
          end
        end
      end
    end
  end

  describe "as a visitor" do
    describe "when I visit an application's show page and I have added one or more pets to the application" do
      describe "Then I see a section to submit my application and in that section I see an input to enter why I would make a good owner for these pet(s)" do
        describe "When I fill in that input and I click a button to submit this application" do
          it "I am taken back to the application's show page, I see an indicator that the application is 'Pending', I see all the pets that I wat to adopt, and I do not see a section to add more pets to this application" do
            application = Application.create!(
              name: "John Smith",
              street_address: "1234 Lane Street",
              city: "Happy City",
              state: "CO",
              zip_code: "80111",
              owner_description: "I want an animal",
              status: "In Progress"
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
            
            fill_in "Search for pets by name", with: "Cheesecake"

            click_button "Submit"

            click_button "Adopt this Pet"

            expect(page).to have_content("Why would you make a good owner for these pet(s)?")
            expect(page).to have_button("Submit Application")

            fill_in "Why would you make a good owner for these pet(s)?", with: "Because I am amazing"

            click_button("Submit Application")

            expect(current_path).to eq("/applications/#{application.id}")

            within("#status") do
              expect(page).to have_content("Pending")
            end

            within("#pets") do
              expect(page).to have_content("Cheesecake")
            end

            within ("#pet-add") do
              expect(page).not_to have_content("Add a Pet to this Application")
              expect(page).not_to have_content("Search for pets by name")
              expect(page).not_to have_button("Submit")
            end
          end
        end
      end
    end
  end
end
