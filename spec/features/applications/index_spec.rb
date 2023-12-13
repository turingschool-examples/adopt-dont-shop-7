require "rails_helper"
RSpec.describe "application index page" do

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
end 
    



# describe "As a visitor" do
#   describe "when I visit /applications index page" do
#     # US 2 Part 2
#     it "displays a form to create a new application" do
#       # As a visitor
#       # When I visit the pet index page
#       # Then I see a link to "Start an Application"
#       # When I click this link
#       # Then I am taken to the new application page where I see a form
#       # When I fill in this form with my:
#       #   - Name
#       #   - Street Address
#       #   - City
#       #   - State
#       #   - Zip Code
#       #   - Description of why I would make a good home
#       # And I click submit
#       # Then I am taken to the new application's show page
#       # And I see my Name, address information, and description of why I would make a good home
#       # And I see an indicator that this application is "In Progress"

#       visit "/applications/new"

#       fill_in "Name", with: "Roman"
#       fill_in "Street Address", with: "444 Berry Way"
#       fill_in "City", with: "Boulder"
#       fill_in "State", with: "CO"
#       fill_in "Zip", with: "88888"
#       fill_in "Description of why I would make a good home", with: "A loving family."
#       fill_in "Status", with: "In Progress"
#       click_button "Submit"

#       expect(current_path).to eq("/applications/#{@app2.id + 1}")

#       expect(page).to have_content("Roman")
#       expect(page).to have_content("444 Berry Way")
#       expect(page).to have_content("A loving family")
#       expect(page).to have_content("In Progress")
#     end
#   end