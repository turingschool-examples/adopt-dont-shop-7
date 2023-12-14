require "rails_helper"

RSpec.describe "New Application Form", type: :feature do
  before(:each) do
    @app1 = Application.create!(name: "Sam", address: "106 Chatsworth Circle", city: "Sugar Land", state: "TX", zipcode: "77456",description: "Needs a loyal friend", status: "In Progress")
    @app2 = Application.create!(name: "Poca", address: "7021 Garland", city: "Richmond", state: "TX", zipcode: "77407",description: "Needs a loyal friend", status: "In Progress")
    @app3 = Application.create!(name: "Prince", address: "4719 Rose Ambers Court", city: "Fresno", state: "TX", zipcode: "77545",description: "Wonderful companion on boring days", status: "Accepted")
    @app4 = Application.create!(name: "Taj", address: "22655 Briar Forest Drive", city: "Houston", state: "TX", zipcode: "77077",description: "Wonderful companion on boring days", status: "In Progress")
    
    @s1 = Shelter.create!(foster_program: true, name: "Dogtopia", city: "Houston", rank: 2)
    
    @pet1 = Pet.create!(name: "Buddy", adoptable: true, age: 5, breed: "Shiba", shelter_id: @s1.id)
    @pet2 = Pet.create!(name: "Jackie", adoptable: false, age: 1, breed: "Inu", shelter_id: @s1.id)
    @pet_app1 = PetApplication.create!(application: @app1, pet: @pet2)
    @pet_app2 = PetApplication.create!(application: @app2, pet: @pet1)
  end

  
  # USer Story 3
 it "handles invalid input in the new form field" do
  # As a visitor
  # When I visit the new application page
  # And I fail to fill in any of the form fields
  # And I click submit
  # Then I am taken back to the new applications page
  # And I see a message that I must fill in those fields.

  visit "/applications/new"

  fill_in "Name", with: "Chief Chris"

  click_button "Submit"
  
  expect(current_path).to eq("/applications/new")
  expect(page).to have_content("Each field must be complete")  
  end
end 