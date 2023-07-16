require 'rails_helper'

RSpec.describe 'application show page' do 
before :each do 
  @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter', city: 'Denver', foster_program: false, rank: 9)
  @shelter_2 = Shelter.create!(name: 'Boulder Animal Shelter', city: 'Boulder', foster_program: false, rank: 7)
  @shelter_3 = Shelter.create!(name: 'Dallas Animal Shelter', city: 'Dallas', foster_program: false, rank: 2)

  @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'Golden Retriever', name: 'Buddy')
  @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'American Bulldog', name: 'Rover')
  @pet_3 = @shelter_3.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Max')
  @pet_4 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'Spud')
  @pet_5 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'SpuddyBuddy')

  @application_1 = Application.create!(name: 'John Smith', street_address: '1234 Fake Street', city: 'Denver', state: 'CO', zip_code: 80202, description: 'Big Yak guy, but a dog will do', status: 'In Progress')
  @application_2 = Application.create!(name: 'Jane Doe', street_address: '5678 Wannabe Road', city: 'Boulder', state: 'CO', zip_code: 80301, description: 'I love cats!', status: 'In Progress')
  @application_3 = Application.create!(name: 'Joe Schmoe', street_address: '90210 Round Drive', city: 'Dallas', state: 'TX', zip_code: 75214, description: 'I like Turtles!', status: 'In Progress')
end

  # US_1 Application Show Page
  describe 'when I visit the applications show page' do 
    it 'displays the application form' do 
      @application_1.pets << @pet_1
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street_address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip_code)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
      expect(page).to have_link(@pet_1.name)
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

  describe 'when I visit an applications show page' do
    describe 'then I see a section on the page to "Add a Pet to this Application"' do
      it 'has an input where I can search for Pets by name' do 

        visit "/applications/#{@application_3.id}"

        expect(page).to have_content('Add a Pet to this Application')
      end
    end
      it 'I see an input where I can search for Pets by name' do 
        visit "/applications/#{@application_3.id}"
        
        expect(page).to have_field('Search by Pet Name:')
        
        fill_in :pet_name, with: "Spud"
        
        click_button "Submit"
        
        expect(current_path).to eq("/applications/#{@application_3.id}")
        expect(page).to have_content("Spud")
        expect(page).to have_content("SpuddyBuddy")
      end
  end
end