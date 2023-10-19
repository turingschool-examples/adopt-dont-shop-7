require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/applications/:id'" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = @shelter_1.pets.create(name: "Auggie", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @pet_2 = @shelter_1.pets.create(name: "Rue", breed: "shorthair", age: 3, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
        @application_1 = @pet_1.applications.create!(name: "Julie Johnson", address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", to_adopt: "Auggie", status: "In Progress")
        @application_2 = @pet_2.applications.create!(name: "Steve Smith", address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", to_adopt: "Rue", status: "Accepted")
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
        expect(page).to have_content(@application_1.to_adopt)
        expect(page).to have_content(@application_1.status)
        # save_and_open_page
      end 

      it "links to the pets show page" do
        visit "/applications/#{@application_1.id}"

        click_on "#{@pet_1.name}"

        expect(current_path).to eq "/pets/#{@pet_1.id}"
      end
    end 
  end 
end