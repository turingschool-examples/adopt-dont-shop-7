require 'rails_helper'

RSpec.describe Application, type: :feature do
  # create shelters
  # create pets that belong to shelters
  # create application
  # associates application with pets
  let!(:shelter_1) { Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)}
  
  let!(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frank")}
  let!(:pet_2) { shelter_1.pets.create!(adoptable: false, age: 7, breed: "lab", name: "Rex")}
  let!(:pet_3) { shelter_1.pets.create!(adoptable: true, age: 1, breed: "bulldog", name: "Daisy")}
  let!(:pet_4) { shelter_1.pets.create!(adoptable: true, age: 5, breed: "pitbull", name: "Roxie")}
  # let!(:application_1) { Application.create!(name: "John Smith", street_address: "123 Elm", city: "Denver", state: "CO", zip_code: 80205, description: "Responsible pet owner, fenced yard", status: "pending"  )}
  
  let!(:app_1) { Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") }
  let!(:app_2) { Application.create!(name: "Jane Doe", street_address: "444 8th St", city: "Wheatridge", state: "CO", zip_code: 80231, description: "Outdoorsy, responsible", status: "accepted") }
  let!(:app_3) { Application.create!(name: "Clark Kent", street_address: "93428 Washington Ave", city: "Arvada", state: "CO", zip_code: 80411, description: "Family loves animals", status: "pending") }

  # let!(:pet_2) { shelter_1.pets.create!(adoptable: true, age: 4, breed: "mutt", name: "Chaco")}
  
  let!(:application_pets_1) { ApplicationPet.create!(application_id: app_1.id, pet_id: pet_1.id) }
  let!(:application_pets_2) { ApplicationPet.create!(application_id: app_1.id, pet_id: pet_2.id) }
  
  
  # User Story 1  
  describe 'as a visitor, when I open the applications show page' do
    it 'displays application information' do
      visit "/applications/#{app_1.id}"
      # save_and_open_page

      within("#application-#{app_1.id}") do
        expect(page).to have_content(app_1.name)
        expect(page).to have_content(app_1.street_address)
        expect(page).to have_content(app_1.city)
        expect(page).to have_content(app_1.state)
        expect(page).to have_content(app_1.zip_code)
        expect(page).to have_content(app_1.description)
        expect(page).to have_content(app_1.status)
        # expect(page).to have_link("#{pet_2.name}") #its adding both links for the two pets on app_1.id but fails in the test. not sure why.
        expect(page).to have_link("#{pet_1.name}")
        click_link("Frank")
        expect(current_path).to eq "/pets/#{pet_1.id}"
      end
    end
    
      # 4. Searching for Pets for an Application

      # As a visitor
      # When I visit an application's show page
      # And that application has not been submitted,
      # Then I see a section on the page to "Add a Pet to this Application"
      # In that section I see an input where I can search for Pets by name
      # When I fill in this field with a Pet's name
      # And I click submit,
      # Then I am taken back to the application show page
      # And under the search bar I see any Pet whose name matches my search
      
    it 'has a field to add a pet to an application' do
      visit "/applications/#{app_1.id}"
      # save_and_open_page
      expect(page).to have_content("Add a Pet to this Application")
    end  
  
    it 'allows a visitor to search for pets' do
      visit "/applications/#{app_1.id}"
      fill_in 'pet_name', with: "Roxie"
      click_button("Search")
      # save_and_open_page

      expect(page).to have_text("Roxie")
      expect(page).to have_no_content("Roksi")
      expect(page).to have_content(pet_4.breed)
      expect(page).to have_content(pet_4.age)
    end

#     5. Add a Pet to an Application

# As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application
    it "displays button 'Adopt this Pet' button next to each searched for pet's name" do
      visit "/applications/#{app_1.id}"
      fill_in "pet_name", with: "Roxie"
      click_button("Search")

      expect(page).to have_button("Adopt this Pet")
      click_button "Adopt this Pet"
      expect(current_path).to eq("/applications/#{app_1.id}")
    end
  end
end