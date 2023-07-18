require "rails_helper"

describe "Admin/index page:" do
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
  describe "When I visit the admin shelter index ('/admin/shelters')" do
    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      visit "/admin/shelters"
      
      expect(@shelter_2.name).to appear_before(@shelter.name)
      expect(@shelter.name).to appear_before(@shelter_1.name)
    end

    it "I see a section for 'Shelters with Pending Applications' and in this section I see the name of every shelter that has a pending application" do
      visit "/admin/shelters"
      save_and_open_page
      expect(page).to have_content("Shelters with Pending Applications")

        within "#pending_applications" do
          expect("Shelters with Pending Applications").to appear_before(@shelter.name)
        end
    end
  end
end