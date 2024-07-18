require "rails_helper"

RSpec.describe "the admin applications show page" do
  before(:each) do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: @shelter.id)
    @app1 = Application.create!(name: "Shaggy",
                                street_address: "1234 Bobs rd",
                                city: "Denver",
                                state: "Colorado",
                                zip_code: "80220",
                                description: "I want a dog!",
                                status: "In Progress")
    @app2 = Application.create!(name: "Fred",
                                street_address: "1234 Fred rd",
                                city: "Boulder",
                                state: "Colorado",
                                zip_code: "80221",
                                description: "I NEED a dog!",
                                status: "In Progress")
    PetApplication.create!(application: @app1, pet: @pet1, status: "Pending")
    PetApplication.create!(application: @app1, pet: @pet2, status: "Pending")

    PetApplication.create!(application: @app2, pet: @pet1, status: "Pending")
    PetApplication.create!(application: @app2, pet: @pet2, status: "Pending") 
  end
  
  # User Story 12
  describe "as a visitor, when I visit the admin application show page" do 
    it "there is a functional button to APPROVE next to every pet on the application" do
      visit "/admin/applications/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        click_button "Approve This Pet"
      end

      within("#pet-#{@pet2.id}") do
        expect(page).to have_button("Approve This Pet")
      end

      expect(current_path).to eq "/admin/applications/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        expect(page).to_not have_content("Approve This Pet")
        expect(page).to have_content("Approved!")
      end

      within("#pet-#{@pet2.id}") do
        expect(page).to have_button("Approve This Pet")
      end
    end

    # User Story 13
    it "there is a functional button to REJECT next to every pet on the application" do
      visit "/admin/applications/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        click_button "Reject This Pet"
      end

      within("#pet-#{@pet2.id}") do
        expect(page).to have_button("Reject This Pet")
      end

      expect(current_path).to eq "/admin/applications/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        expect(page).to_not have_content("Reject This Pet")
        expect(page).to have_content("Rejected!")
      end

      within("#pet-#{@pet2.id}") do
        expect(page).to have_button("Reject This Pet")
      end
    end

    # User Story 14
    it "does not affect status of pets on another application" do 
      visit "/admin/applications/#{@app1.id}"

      within("#pet-#{@pet1.id}") do
        click_button "Approve This Pet"
      end

      within("#pet-#{@pet2.id}") do
        click_button "Reject This Pet"
      end

      visit "/admin/applications/#{@app2.id}"
      
      within("#pet-#{@pet1.id}") do
        expect(page).to have_button("Approve This Pet")
        expect(page).to have_button("Reject This Pet")
        expect(page).to_not have_content("Approved!")
        expect(page).to_not have_content("Rejected!")
      end

      within("#pet-#{@pet2.id}") do
        expect(page).to have_button("Approve This Pet")
        expect(page).to have_button("Reject This Pet")
        expect(page).to_not have_content("Approved!")
        expect(page).to_not have_content("Rejected!")
      end
    end
  end
end

