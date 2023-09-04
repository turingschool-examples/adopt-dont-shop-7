require "rails_helper"

RSpec.describe "the Application show page", type: :feature do
  describe "As a visitor" do
    describe "when I visit an application show page" do
      before :each do
        @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet = Pet.create!(adoptable: true, age: 1, breed: "doberman", name: "Spot", shelter_id: @shelter.id)
        @pet1 = Pet.create!(adoptable: true, age: 6, breed: "pug", name: "Adonis", shelter_id: @shelter.id)
        @application = Application.create!(name: "John Smith", street_address: "123 Main st", city: "Boulder", state: "CO", zip_code: "12345", description: "I'm rich.", status: "In Progress")
        PetApplication.create!(pet: @pet, application: @application)
        visit "/applications/#{@application.id}"
      end

      it "I see applicants attributes" do
        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.address)
        expect(page).to have_content(@application.description)
      end

      it "I see names of all pets the application is for" do
        within("#mypets-#{@application.id}") do
          expect(page).to have_content(@pet.name)
        end
      end

      it "the pets names are links to their show pages" do
        click_on "#{@pet.name}"

        expect(current_path).to eq("/pets/#{@pet.id}")
      end

      it "I see the applications status" do
        expect(page).to have_content(@application.status)
      end
      
      # US 4
      it "I see a section to Add a pet to the application" do
        expect(page).to have_content("Add a Pet to this Application")
        
        fill_in "search", with: "Adonis"

        click_button "Submit"

        expect(current_path).to eq("/applications/#{@application.id}")

        within("#searched-#{@application.id}") do
          expect(page).to have_content(@pet1.name)
          expect(page).to have_content(@pet1.breed)
          expect(page).to have_content(@pet1.age)
        end
      end
      
      # US 5
      it "I see a button to Adopt this pet next to each searched pet name" do
        fill_in "search", with: "Adonis"
        click_button "Submit"
        click_button "Adopt this Pet"
        
        expect(current_path).to eq("/applications/#{@application.id}")
        
        within("#mypets-#{@application.id}") do
          expect(page).to have_content(@pet1.name)
        end
      end

      # US 6
      it "I see a section to submit my application" do
        fill_in "search", with: "Adonis"
        click_button "Submit"
        click_button "Adopt this Pet"
        fill_in "good_owner_reason", with: "I have a big house."
        click_button "Submit this Application"

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Pending")
        within("#mypets-#{@application.id}") do
          expect(page).to have_content(@pet.name)
          expect(page).to have_content(@pet1.name)
        end
        expect(page).not_to have_content("Add a Pet to this Application")
      end
    end
  end
end