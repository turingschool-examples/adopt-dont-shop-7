require 'rails_helper'
# As a visitor
# When I visit an applications show page
# Then I can see the following:

# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'applications show page' do
  it 'can see all the applicants info on the page' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.endorsement)
    expect(page).to have_content("In Progress")
  end

  it 'has an Add a Pet section' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

        #User story 4
        #   As a visitor
        # When I visit an application's show page
    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet To This Application")
  end
  
  it 'should have a search bar to search for pets by name' do
    # And that application has not been submitted,
    
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a Pet To This Application")
    expect(page).to have_field("search")
  end

  it "can add to the search bar and push submit" do
    # When I fill in this field with a Pet's name
    # And I click submit,
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

    visit "/applications/#{application.id}"

    fill_in "search", with: "test pet"
    click_on "Search"

    # Then I am taken back to the application show page
    expect(current_path).to eq("/applications/#{application.id}")
  end

  it "displays pets whose name matches the search" do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)
    
    # And under the search bar I see any Pet whose name matches my search
    fill_in "Search", with: "Elle"

    click_on "Search"
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_3.breed)
    expect(page).to have_content(pet_3.age)
  end
    
    
end