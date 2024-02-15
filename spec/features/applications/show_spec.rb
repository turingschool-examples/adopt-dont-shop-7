require 'rails_helper'


RSpec.describe "Application show", type: :feature do
    describe 'application show' do
        
    before(:each) do
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
        @application_1 = Application.create!(name: "Lance", street_address: "123 sesame street", city: "Brooklyn", state: "New York", zip_code: "10012", description: "I like dogs", status: "In Progress")
        @application_2 = Application.create!(name: "Nico", street_address: "125 sesame way", city: "Miami", state: "Florida", zip_code: "63016", description: "I have an unlimited supply of poop bags", status: "In Progress")
        # PetApplication.create!(applications_id: @application_1.id, pets_id: @pet_1.id)
    end     
        
        it 'shows the name of the applicant and attributes' do
            
            PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
            PetApplication.create!(application_id: @application_2.id, pet_id: @pet_1.id)
            # When I visit an applications show page
            visit "/applications/#{@application_1.id}"
            
            # - Name of the Applicant
            expect(page).to have_content(@application_1.name)
            # - Full Address of the Applicant including street address, city, state, and zip code
            expect(page).to have_content(@application_1.street_address)
            expect(page).to have_content(@application_1.city)
            expect(page).to have_content(@application_1.state)
            expect(page).to have_content(@application_1.zip_code)
            # - Description of why the applicant says they'd be a good home for this pet(s)
            expect(page).to have_content(@application_1.description)
            # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
            expect(page).to have_content(@application_1.status)
            
            expect(page).to_not have_content(@application_2.name)
            expect(page).to_not have_content(@application_2.street_address)
            expect(page).to_not have_content(@application_2.city)
            expect(page).to_not have_content(@application_2.state)
            expect(page).to_not have_content(@application_2.zip_code)
            expect(page).to_not have_content(@application_2.description)
        end
        
        it 'links to dog show page of applied for pet' do
            # - names of all pets that this application is for (all names of pets should be links to their show page)
            PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
            PetApplication.create!(application_id: @application_1.id, pet_id: @pet_2.id)
        
            visit "/applications/#{@application_1.id}"
            expect(page).to have_link(@pet_1.name, :href=>"/pets/#{@pet_1.id}")
            expect(page).to have_link(@pet_2.name, :href=>"/pets/#{@pet_2.id}")

        end

            # 4. Searching for Pets for an Application
        it 'adds a section called add a pet the application show page where user can search for pets by name' do
            # PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
            # PetApplication.create!(application_id: @application_1.id, pet_id: @pet_2.id)
            # When I visit an application's show page
            visit "/applications/#{@application_1.id}"
            # And that application has not been submitted,
            expect(page).to have_content("In Progress")
            # Then I see a section on the page to "Add a Pet to this Application"
            expect(page).to have_content("Add a Pet to this Application")
            # In that section I see an input where I can search for Pets by name
            expect(find("form")).to have_content("Search for pets by name")
            # When I fill in this field with a Pet's name
            fill_in :search, with: "Lobster"
            # And I click submit,
            click_button "submit"
            # Then I am taken back to the application show page
            expect(current_path).to eq("/applications/#{@application_1.id}")
            # And under the search bar I see any Pet whose name matches my search
            expect(page).to have_content("Lobster")
            expect(page).to_not have_content("Lucille Bald")
        end

            # 5. Add a Pet to an Application
        it "Add a Pet to an Application" do
            
            # As a visitor
            # When I visit an application's show page
            visit "/applications/#{@application_1.id}"
            # And I search for a Pet by name
            fill_in "Search for pets by name", with: "Lucille Bald"
            click_on("submit")
            # And I see the names Pets that match my search
            expect(page).to have_content("Lucille Bald")
            # Then next to each Pet's name I see a button to "Adopt this Pet"
            expect(page).to have_button("Adopt this Pet")
            # When I click one of these buttons
            click_button("Adopt this Pet")
            # Then I am taken back to the application show page
            expect(current_path).to eq("/applications/#{@application_1.id}")
            # And I see the Pet I want to adopt listed on this application
            expect(page).to have_content("Lucille Bald")

        end
    end
end

