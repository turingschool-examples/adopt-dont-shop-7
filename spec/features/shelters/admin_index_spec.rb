require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @mr_p = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @catsby = @shelter_2.pets.create(name: "The Great Catsby", breed: "tuxedo", age: 4, adoptable: true)
    @applicant_1 = Application.create!(name: 'Steven', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "Pending"
    )
    PetApplication.create!(pet_id: @mr_p.id, application_id: @applicant_1.id)
    PetApplication.create!(pet_id: @catsby.id, application_id: @applicant_1.id)

  end

  #user story 10
  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  #user story 11
  it "lists all shelters with pending applications" do
    visit "/admin/shelters"

    within("#shelters_with_pending_apps") do
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).not_to have_content(@shelter_3.name)
    end
  end
end