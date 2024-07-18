require "rails_helper"

RSpec.describe "the applications show" do
  # 2. Starting an Application

  # As a visitor
  # When I visit the pet index page
  # Then I see a link to "Start an Application"
  # When I click this link
  # Then I am taken to the new application page where I see a form
  # When I fill in this form with my:
  #   - Name
  #   - Street Address
  #   - City
  #   - State
  #   - Zip Code
  #   - Description of why I would make a good home
  # And I click submit
  # Then I am taken to the new application's show page
  # And I see my Name, address information, and description of why I would make a good home
  # And I see an indicator that this application is "In Progress"

  #   [ ] done

  # 3. Starting an Application, Form not Completed

  # As a visitor
  # When I visit the new application page
  # And I fail to fill in any of the form fields
  # And I click submit
  # Then I am taken back to the new applications page
  # And I see a message that I must fill in those fields.

  before :each do
    @shelter1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @shelter2 = Shelter.create!(name: "Fuzzy Paws", city: "Boulder CO", foster_program: false, rank: 4)
    @shelter3 = Shelter.create!(name: "Good Boys", city: "New York NY", foster_program: true, rank: 2)
    @shelter4 = Shelter.create!(name: "Roshar Creatures", city: "Whimsical", foster_program: false, rank: 1)

    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Dozer", age: 6, breed: "Pitbull", adoptable: true, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Gunther", age: 10, breed: "Rottweiler", adoptable: true, shelter_id: @shelter3.id)
    @pet4 = Pet.create!(name: "Carl", age: 7, breed: "Goat", adoptable: false, shelter_id: @shelter4.id)

    @application1 = Application.create!(name: "Joe Baeza", street_address: "12345 Joe Street", city: "Irvine", state: "CA", zip_code: "54321",
                                        description: "I like Scooby and Carl so I want to adopt them", status: "Pending")
    @application2 = Application.create!(name: "Billy Bob", street_address: "56789 The Bob Street", city: "Boulder", state: "CO", zip_code: "09876",
                                        description: "Dozer looks badass and I am a guy who wants a badass dog.", status: "Pending")

    @pet_application1 = PetApplication.create!(application: @application1, pet: @pet1)
  end

  describe "As a visitor do" do
    describe "when I visit the pet index page" do 
      it "will display a link to start a new application " do
        visit "/pets"

        expect(page).to have_link("Start an Application")

        click_link "Start an Application"

        expect(page).to have_current_path("/applications/new")
      end

      it "will have a new application form for the user to fill out that returns the user to the show page if all fields are fill out" do
        visit "/applications/new"

        within ("#new-application") do
          fill_in 'name', with: 'Joseph'
          fill_in 'street_address', with: '1273 The Street of Joseph'
          fill_in 'city', with: 'Seattle'
          fill_in 'state', with: 'Washington'
          fill_in 'zip_code', with: '93485'
          fill_in 'description', with: 'I want a pet man.'

          click_button "Submit Application"
        end

        new_app = Application.last

        expect(page).to have_current_path("/applications/#{new_app.id}")

        expect(page).to have_content("Applicant: #{new_app.name}")
        expect(page).to have_content("Address: #{new_app.street_address}, #{new_app.city}, #{new_app.state}, #{new_app.zip_code}")
        expect(page).to have_content("Description: #{new_app.description}")
        expect(page).to have_content("Pets:") # why does the string interpolation not work and return Pets: Pet
        expect(page).to have_content("Status: #{new_app.status}")
        expect(page).to have_content("Status: In Progress")
      end

      it "will prompt the user to fill out the form if they submit an uncompleted form" do
        
        visit "/applications/new"

        within ("#new-application") do
          fill_in 'name', with: 'Joseph'
          fill_in 'city', with: 'Seattle'
          fill_in 'state', with: 'Washington'
          fill_in 'description', with: 'I want a pet man.'

          click_button "Submit Application"
        end

        new_app = Application.last

        expect(page).to have_current_path("/applications/new")

        expect(page).to have_content("You must fill out all the fields for the Application Form. Try Again")

        within ("#new-application") do
          fill_in 'name', with: 'Joseph'
          fill_in 'street_address', with: '1273 The Street of Joseph'
          fill_in 'city', with: 'Seattle'
          fill_in 'state', with: 'Washington'
          fill_in 'zip_code', with: '93485'
          fill_in 'description', with: 'I want a pet man.'

          click_button "Submit Application"
        end

        new_app = Application.last

        expect(page).to have_current_path("/applications/#{new_app.id}")

        expect(page).to have_content("Applicant: #{new_app.name}")
        expect(page).to have_content("Address: #{new_app.street_address}, #{new_app.city}, #{new_app.state}, #{new_app.zip_code}")
        expect(page).to have_content("Description: #{new_app.description}")
        expect(page).to have_content("Pets:") # why does the string interpolation not work and return Pets: Pet
        expect(page).to have_content("Status: #{new_app.status}")
        expect(page).to have_content("Status: In Progress")
      end
    end
  end
end