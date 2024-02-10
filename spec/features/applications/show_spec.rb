require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "Luis Aparicio", street_address: "7511 James St", city: "Menasha", state: "WI", zipcode: "54952", description: "I love pets!", application_status: "Pending")
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter_1.id)

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
  
  end

  it "Show's a specific applicant's details" do
    #User Story 1

    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.zipcode)
    expect(page).to have_content(@application_1.application_status)
  end
end