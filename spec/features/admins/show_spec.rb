require "rails_helper"

RSpec.describe "the admin/applications/:id show page" do
  describe "When I visit /admin/applications/:id" do
    before :each do
      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
      @pet = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet1 = @shelter_1.pets.create(name: "Mr. Coffee", breed: "sphinx", age: 2, adoptable: true)
      @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

      @application = Application.create!(name: "John Smith", street_address: "123 Main st", city: "Boulder", state: "CO", zip_code: "12345", description: "I'm rich.", status: "Pending")
      PetApplication.create!(pet: @pet, application: @application)
      PetApplication.create!(pet: @pet1, application: @application)
      visit "/admin/applications/#{@application.id}"
    end

    # US 12
    it "For every pet I see a button to approve" do
      
      within("#pet-#{@pet.id}") do
        expect(page).to have_button("Approve")
      end

      within("#pet-#{@pet1.id}") do
        expect(page).to have_button("Approve")
      end

      click_button("Approve", match: :first)

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within("#pet-#{@pet.id}") do
        expect(page).not_to have_button("Approve")
        expect(page).to have_content("*Approved")
      end
    end

    # US 13
    it "For every pet I see a button to reject" do
      
      within("#pet-#{@pet.id}") do
        expect(page).to have_button("Reject")
      end

      within("#pet-#{@pet1.id}") do
        expect(page).to have_button("Reject")
      end

      click_button("Reject", match: :first)

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      within("#pet-#{@pet.id}") do
        expect(page).not_to have_button("Accept")
        expect(page).not_to have_button("Reject")
        expect(page).to have_content("*Rejected")
      end
    end
  end
end