require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "Luis Aparicio", street_address: "7511 James St", city: "Menasha", state: "WI", zipcode: "54952", description: "I love pets!", application_status: "Pending")
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter_1.id)

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @application_2 = Application.create!(name: "test", street_address: "test James St", city: "ena", state: "az", zipcode: "52332", description: "I love2 pets!",application_status: "In Progress")
    
  end

  #User Story 1
  it "Show's a specific applicant's details" do
    

    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.zipcode)
    expect(page).to have_content(@application_1.application_status)

    expect(page).to have_content(@pet_1.name)
  end
  
  it "Links to each pets show page" do

    visit "/applications/#{@application_1.id}"

    click_on @pet_1.name

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  
  end
  
  #User Story 4
  it "searches pets for pets in a not submitted application" do
    visit "/applications/#{@application_2.id}"
    expect(page).to have_content(@application_2.name)
    expect(page).to have_content(@application_2.street_address)
    expect(page).to have_content(@application_2.city)
    expect(page).to have_content(@application_2.state)
    expect(page).to have_content(@application_2.description)
    expect(page).to have_content(@application_2.zipcode)
    expect(page).to have_content("In Progress")
    expect(page).to have_content("add a pet to this Application")

    fill_in :name_pet, with: "Scooby"
    click_on "Submit"

    expect(current_path).to eq("/applications/#{@application_2.id}")
    expect(page).to have_content("Scooby")
  end
end

# 5. Add a Pet to an Application

# As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application

it "I see a button to add a pet to the application" do

  visit "/applications/#{@application_2.id}"

  expect(page).to have_content("add a pet to this Application")

  fill_in :name_pet, with: "Scooby"
  click_on "Submit"


  click_button("Adopt this pet")

  expect(path.current_path).to eq("/applications/#{@application_2.id}")
  expect(page).to have_content("Scooby")
end