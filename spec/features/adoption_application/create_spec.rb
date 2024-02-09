require "rails_helper"

RSpec.describe "the adoption application create page", type: :feature do
    
    # As a visitor
    # When I visit the pet index page
    # Then I see a link to "Start an Application"
    # When I click this link    
    # User Story 2
    describe "can create new adoption applications" do
        before :each do 
            @shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
            @pet_1 = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
            @pet_2 = Pet.create(name: "Scrappy", age: 1, breed: "Pit Mix", adoptable: true, shelter_id: shelter.id)
            @application = pet_2.adoption_applications.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
        end

        it "displays a form" do
            visit "/applications/create"

            expect(page).to have_button("Submit Application")
        end

        # Then I am taken to the new application page where I see a form
        # When I fill in this form with my:
        #   - Name, Street Address, City, State, Zip Code,
        #   & Description of why I would make a good home
        it "is a fillable form with name, address, and description" do
            visit "/applications/create"

            expect(page).to have_field("Name")
            expect(page).to have_field("Street Address")
            expect(page).to have_field("City")
            expect(page).to have_field("State")
            expect(page).to have_field("Zip Code")
            expect(page).to have_field("Description of why you are a good owner")
        end

        # And I click submit
        # Then I am taken to the new application's show page
        it "goes to adoption application show page after submission" do
            visit "/applications/create"

            fill_in "Name", with: "Mel"
            fill_in "Street Address", with: "23 Main St"
            fill_in "City", with: "Denver"
            fill_in "State", with: "CO"
            fill_in "Zip Code", with: "80303"
            fill_in "Description of why you are a good owner", with: "I have a fenced backyard and love dogs"

            click_button "Submit Application"

            newest_app_id = AdoptionApplication.last.id

            expect(current_path).to eq("/applications/#{new_application_id}")
            # add more expects with page details
        end

        # Does this go in the show_spec?
        # And I see my Name, address information, and description of why I would make a good home
        # And I see an indicator that this application is "In Progress"
        it "updates the adoption application show page" do
            visit "/applications/create"

            fill_in "Name", with: "Mel"
            fill_in "Street Address", with: "23 Main St"
            fill_in "City", with: "Denver"
            fill_in "State", with: "CO"
            fill_in "Zip Code", with: "80303"
            fill_in "Description of why you are a good owner", with: "I have a fenced backyard and love dogs"

            click_button "Submit Application"

            expect(AdoptionApplication.last.status).to eq("In Progress")
        end
    end
end