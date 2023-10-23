require 'rails_helper'

RSpec.describe 'Application Show Page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @pet_2 = @shelter_1.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    #After creatings pets, put the pet link in place of pets for Stacy
  end

  it 'displays the attribute of the applicant' do
    application_1 = @application
    visit "/applications/#{application_1.id}"
    expect(page).to have_content("Name of Applicant")
    expect(page).to have_content("Address")
    expect(page).to have_content("Description of Qualification")
    expect(page).to have_content("Pets Applied For")
    expect(page).to have_content("Application Status")
  end

  it 'displays pets applied for as a button that will redirect to the pet show page' do
    application_1 = @application
    pet_test = @pet_2
    visit "/applications/#{application_1.id}"
    expect(page).to have_content("Add a Pet to this Application")
    fill_in "Search for Pets", with: "Babe"
    click_button "Submit"
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(pet_test.name)
    click_button "Adopt #{pet_test.name}"
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(pet_test.name)
    click_link "#{pet_test.name}"
    expect(current_path).to eq("/pets/#{pet_test.id}")
  end

  it 'puts the address together for applicant' do
    visit "/applications/#{@application.id}"
    expect(page).to have_content("1870 Canopy Rd, Los Angeles, CA, 90001")
  end

  # USER STORY 4
  it "displays option to add a pet to application" do
    visit "/applications/#{@application.id}"
    
    expect(page).to have_content("Add a Pet to this Application")

    fill_in "Search for Pets", with: "Babe"

    click_button "Submit"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.breed)
    expect(page).to have_content(@pet_2.age)
  end

  ## USER STORY 5
  it "has an adopt this pet button after each pet" do
    @application = Application.first
    visit "/applications/#{@application.id}"
    expect(page).to have_content("Add a Pet to this Application")
    fill_in "Search for Pets", with: "Babe"
    click_button "Submit"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content(@pet_2.name)
    click_button "Adopt #{@pet_2.name}"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content(@pet_2.name)
  end

  ## USER STORY 6

end
