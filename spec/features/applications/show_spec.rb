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
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
    
    # And under the search bar I see any Pet whose name matches my search
    visit "/applications/#{application.id}"
    fill_in "search", with: "Elle"

    click_on "Search"
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.age)
  end

# As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application
  it "has an adopt this pet button next to each pet" do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")

    visit "/applications/#{application.id}"
    fill_in "search", with:"#{pet.name}"
    click_on "Search"

    expect(page).to have_button("Adopt this Pet")
  end

  it "can click the adopt this pet button, and that pet will be added to the application" do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")

    visit "/applications/#{application.id}"
    fill_in "search", with:"#{pet.name}"
    click_on "Search"
    click_on "Adopt this Pet"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(pet.name).to appear_before("Add a Pet To This Application")
  end    

  #User story 6
#   As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application
  it 'has a section to submit application once a pet is added to it' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")

    visit "/applications/#{application.id}"

    expect(page).not_to have_button("Submit Application")

    fill_in "search", with:"#{pet.name}"
    click_on "Search"
    click_on "Adopt this Pet"

    expect(page).to have_field("owner_endorsement")
    expect(page).to have_button("Submit Application")
  end

  it 'can submit the application and be returned to application show page and see its status as Pending' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")

    visit "/applications/#{application.id}"

    expect(page).not_to have_button("Submit Application")

    fill_in "search", with:"#{pet.name}"
    click_on "Search"
    click_on "Adopt this Pet" 
    fill_in "owner_endorsement", with: "I will be the best owner to this pet"
    click_on "Submit Application"
    
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Application Status: Pending")
  end

  it 'will show pets on application and not show Add a Pet section' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")

    visit "/applications/#{application.id}"

    fill_in "search", with:"#{pet.name}"
    click_on "Search"
    click_on "Adopt this Pet" 
    fill_in "owner_endorsement", with: "I will be the best owner to this pet"
    click_on "Submit Application"

    expect(page).to have_content(pet.name)
    expect(page).not_to have_content("Add a Pet To This Application")
  end

# As a visitor
# When I visit an application show page
# And I search for Pets by name
# Then I see any pet whose name PARTIALLY matches my search
# For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"

  it 'can search for pets by name with only a partial match' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
    pet_2 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Eve")
    pet_3 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Buck")

    visit "/applications/#{application.id}"

    fill_in "search", with: "E"
    click_on "Search"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).not_to have_content(pet_3.name)

    fill_in "search", with: "ck"
    click_on "Search"

    expect(page).to have_content(pet_3.name)
    expect(page).not_to have_content(pet_1.name)
    expect(page).not_to have_content(pet_2.name)
  end

  it 'can search for a pet and get results regardless of capitalization' do
    application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
    pet_2 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Eve")
    pet_3 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Buck")

    visit "/applications/#{application.id}"

    fill_in "search", with: "eLLe"
    click_on "Search"

    expect(page).to have_content(pet_1.name)
    expect(page).not_to have_content(pet_2.name)
    expect(page).not_to have_content(pet_3.name)

    fill_in "search", with: "bUcK"
    click_on "Search"

    expect(page).to have_content(pet_3.name)
    expect(page).not_to have_content(pet_1.name)
    expect(page).not_to have_content(pet_2.name)
  end
end