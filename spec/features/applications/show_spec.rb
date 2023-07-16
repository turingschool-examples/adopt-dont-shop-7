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

  # US_4. Searching for Pets for an Application

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
        
        click_button "Search Pets"
        
        expect(current_path).to eq("/applications/#{@application_3.id}")
        expect(page).to have_content("Spud")
        expect(page).to have_content("SpuddyBuddy")
      end
      # [ ] done

      # US_5. Add a Pet to an Application
      
    describe "When I search for a pets name" do
      describe "I see the names of pets that match my search" do
        it "Then I see a button to adopt this pet" do
          visit "/applications/#{@application_3.id}"

          fill_in :pet_name, with: "Spud"
          
          click_button "Submit"
          expect(page).to have_button("Adopt #{@pet_4.name}")
        end
        
        describe "clicking the button takes me back to the application show page" do
          it "displays the pet I want to adopt on the application" do
            visit "/applications/#{@application_3.id}"
            
            fill_in :pet_name, with: "Spud"
            
            click_button "Submit"
            
            expect(current_path).to eq("/applications/#{Application.last.id}")

            click_button "Adopt Spud"

            within "#pet-#{@pet_4.id}" do 
              expect(page).to have_content("Spud")
            end
          end
        end
      end
    end
  end

  # US_6. Submit an Application

  describe "When I visit an application show page" do 
    describe "and I have added one or more pets to the application" do 
      describe "then I see a section to submit my application" do 
        it 'displays an input to enter why I would make a good owner for these pet(s)' do 
          visit "/applications/#{Application.last.id}"

          click_on "Adopt Spud"
          click_on "Adopt SpuddyBuddy"
        
          expect(page).to have_content("In Progress")
          expect(page).to have_field(:description)
          expect(page).to have_button("Submit")

          fill_in :description, with: "I like african bullfrogs!"
          click_on "Submit"

          expect(current_path).to eq("/applications/#{Application.last.id}")
          expect(page).to have_content("I like african bullfrogs!")

          
          
          within "#pet-#{@pet_4.id}" do 
            expect(page).to have_content("Spud")
          end

          within "#pet-#{@pet_5.id}" do 
            expect(page).to have_content("SpuddyBuddy")
          end
          expect(page).to have_content("Pending")
          
          expect(page).to_not have_content("Add a Pet to this Application")
        end
      end
    end
    # US_7. 
    describe " I have not added any pets to the application" do 
      it 'I do not see a section to submit my application' do 
        visit "/applications/#{@application_3.id}"

        expect(page).to_not have_content("Submit Application")
        expect(page).to_not have_button("Submit Application")
      end
    end
  end
end