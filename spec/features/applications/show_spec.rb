require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/applications/:id'" do
      before(:each) do
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "doberman", name: "Auggie", shelter_id: @shelter_1.id)
        @pet_2 = Pet.create!(adoptable: true, age: 6, breed: "pug", name: "Rue", shelter_id: @shelter_1.id)
        @pet_3 = Pet.create(adoptable: true, age: 3, breed: "boxer", name: "Ann", shelter_id: @shelter_1.id)
        @application_1 = Application.create!(name: "Julie Johnson", street_address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", status: "In Progress")
        @application_2 = Application.create!(name: "Steve Smith", street_address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", status: "Accepted")
        PetApplication.create!(pet: @pet_1, application: @application_1)
      end 

      #User Story 1
      it "displays the applicants information" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zip_code)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.status)
      end 
      
      it "I see names of all pets the application is for" do
        visit "/applications/#{@application_1.id}"
        
        within("#mypets-#{@application_1.id}") do
          expect(page).to have_content(@pet_1.name)
        end
      end
      
      it "links to the pets show page" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@pet_1.name)

        expect(page).to have_link(@pet_1.name)
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit "/applications/#{@application_1.id}"
      end

      it "I see the applications status" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@application_1.status)
      end
    end 
  end 
end