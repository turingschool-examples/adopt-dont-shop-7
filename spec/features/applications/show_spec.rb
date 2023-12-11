require "rails_helper"

RSpec.describe "applications show page" do
  before(:each) do
    @app1 = Application.create!(
      name: "Sam", address: "106 Chatsworth Circle", city: "Sugar Land", state: "TX", zipcode: "77456",
      description: "Needs a loyal friend", status: "In Progress"
    )
    @app2 = Application.create!(
      name: "Poca", address: "7021 Garland", city: "Richmond", state: "TX", zipcode: "77407",
      description: "Needs a loyal friend", status: "In Progress"
    )
    @app3 = Application.create!(
      name: "Prince", address: "4719 Rose Ambers Court", city: "Fresno", state: "TX", zipcode: "77545",
      description: "Wonderful companion on boring days", status: "Accepted"
    )
    @app4 = Application.create!(
      name: "Taj", address: "22655 Briar Forest Drive", city: "Houston", state: "TX", zipcode: "77077",
      description: "Wonderful companion on boring days", status: "In Progress")
    @s1 = Shelter.create!(foster_program: true, name: "Dogtopia", city: "Houston", rank: 2)
    @pet1 = Pet.create!(name: "Buddy", adoptable: true, age: 5, breed: "Shiba", shelter_id: @s1.id)
    @pet2 = Pet.create!(name: "Jackie", adoptable: false, age: 1, breed: "Inu", shelter_id: @s1.id)
    PetApplication.create!(application: @app1, pet: @pet2)
    PetApplication.create!(application: @app2, pet: @pet1)
  
  end 



  it "shows the attributes of the application" do
    # US 1
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    visit "/applications/#{@app1.id}"

    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zipcode)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    #expect(page).to have_link('Buddy')
    #expect(page).to have_link('Jackie')





    expect(page).to have_content @app1.status
  end
end

