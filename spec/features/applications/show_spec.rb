require "rails_helper"

RSpec.describe "the Application show page", type: :feature do
  describe "As a visitor" do
    describe "when i visit an application show page" do
      before :each do
        @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet = Pet.create!(adoptable: true, age: 1, breed: "doberman", name: "Spot", shelter_id: @shelter.id)
        @application = Application.create!(name: "John Smith", street_address: "123 Main st", city: "Boulder", state: "CO", zip_code: "12345", description: "I'm rich.", status: "Pending")
        visit "/applications/:id"
      end

      it "I see applicants attributes" do
        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.address)
        expect(page).to have_content(@application.description)
      end

      it "I see names of all pets the application is for" do
        expect(page).to have_content(@pet.name)
      end

      it "the pets names are links to their show pages" do
        click_on "#{@pet.name}"

        expect(current_path).to eq("/pets/#{@pet.id}")
      end

      it "I see the applications status" do
        expect(page).to have_content(@application.status)
      end
    end
  end
end