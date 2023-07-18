require "rails_helper"

describe "Admin/application/:id page:" do
  before(:each) do
    @shelter = Shelter.create!(name: "Heavenly pets", city: "Aurora, CO", foster_program: true, rank: 7)
    @shelter_1 = Shelter.create!(foster_program: true, name: "County Pet Shelter", city: "Denver", rank: 1)
    @shelter_2 = Shelter.create!(foster_program: true, name: "Yappy Pets", city: "San Clemente", rank: 3)
    @app_1 = Application.create!(name: "John Smith", address: "123 Main", city: "Anytown", state: "CO", zip_code: "80000", description: "Because I have a house", application_status: "In Progress")
    @app_2 = Application.create!(name: "Dan Smith", address: "321 South", city: "Everytown", state: "FL", zip_code: "12345", description: "Because I love animals", application_status: "In Progress")
    @app_3 = Application.create!(name: "Jim Smith", address: "31 North", city: "Everytown", state: "FL", zip_code: "12345", description: "Dogs are cute", application_status: "Pending")
    @pet = Pet.create!(adoptable: true, age: 3, breed: "GSD", name: "Charlie", shelter_id: @shelter.id)
    @pet_1 = Pet.create!(adoptable: true, age: 2, breed: "Golden Retriever", name: "Rover", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 1, breed: "Maine Coon", name: "Kitty", shelter_id: @shelter_1.id)
    @app_1_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @app_1.id)
    @app_3_pet = ApplicationPet.create!(pet_id: @pet.id, application_id: @app_3.id)
  end
  describe "When I visit an admin application show page ('/admin/applications/:id')" do
    it "For every pet that the application is for, I see a button to approve the application for that specific pet" do
      visit "/admin/applications/#{@app_1.id}"
      expect(page).to have_button("Approve application")
    end
    it "When I click that button
    Then I'm taken back to the admin application show page
    And next to the pet that I approved, I do not see a button to approve this pet
      And instead I see an indicator next to the pet that they have been approved" do
      visit "/admin/applications/#{@app_1.id}"
      click_button("Approve application")
      
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      expect(page).to_not have_button("Approve application")
      expect(page).to have_content("Pet Approved")
    end
  end
end