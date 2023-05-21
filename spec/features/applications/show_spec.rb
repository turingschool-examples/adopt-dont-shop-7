require "rails_helper"

RSpec.describe "Application show page" do
  describe 'As a visitor' do
    describe 'When I visit the application show page' do
      before(:each) do
        @joey = Application.create!(name: "Joey", address: "73 Shifty St", city: "Oakland", state: "MA", zip_code: "09342", description: "I'm a good people, totally not robot", status: "In Progress" )
      end
      it 'has the name of the applicant' do
        visit "/applications/#{@joey.id}"
        expect(page).to have_content("Name: #{@joey.name}")
      end

      it 'has the address of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Address: #{@joey.address}")
        expect(page).to have_content("City: #{@joey.city}")
        expect(page).to have_content("State: #{@joey.state}")
        expect(page).to have_content("Zip Code: #{@joey.zip_code}")
      end

      it 'has the description of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Why I would be a good pet owner: #{@joey.description}")
      end

      it 'has the description of the applicant' do
        visit "/applications/#{@joey.id}"

        expect(page).to have_content("Status: #{@joey.status}")
      end

      #user story 4
      # As a visitor
      # When I visit an application's show page
      # And that application has not been submitted,
      # Then I see a section on the page to "Add a Pet to this Application"
      # In that section I see an input where I can search for Pets by name
      # When I fill in this field with a Pet's name
      # And I click submit,
      # Then I am taken back to the application show page
      # And under the search bar I see any Pet whose name matches my search

      it 'can search for a specific pet and get redirected to show page' do
        shelter = Shelter.create!(foster_program: true, name: "Rickys used pets", city: "Sunnyvale", rank: 1)
        zappa = shelter.pets.create!(adoptable: true, age: 4, breed: "poodle", name: "Francesco Zappa")
        # pet_app = PetsApplication.create!(pet_id: zappa.id, pet_status: )

        visit "/applications/#{@joey.id}"
        expect(page).to have_content("Add a Pet to this Application")
        fill_in :search, with: "Francesco Zappa"
        click_button "Search"
        expect(page).to have_content("Francesco Zappa")
        expect(current_path).to eq("/applications/#{@joey.id}")
      end

      it "after we search for a pet, there's a button to adopt the pet" do
        shelter = Shelter.create!(foster_program: true, name: "Rickys used pets", city: "Sunnyvale", rank: 1)
        zappa = shelter.pets.create!(adoptable: true, age: 4, breed: "poodle", name: "Francesco Zappa")
        # pet_app = PetsApplication.create!(pet_id: zappa.id, pet_status: )

        visit "/applications/#{@joey.id}"
        fill_in :search, with: "Francesco Zappa"
        click_button "Search"
        expect(page).to have_content("Francesco Zappa")
        click_button "Adopt this Pet"
        expect(current_path).to eq("/applications/#{@joey.id}")
      end
    end
  end
end
