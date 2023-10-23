require 'rails_helper'

RSpec.describe 'Application Show Page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    
    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter_1.id)
    @pet_2 = @shelter_1.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")

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
  describe "multiple pets on application" do
    before :each do
      @application = Application.first
      visit "/applications/#{@application.id}"

      fill_in "Search for Pets", with: "Babe"
      click_button "Submit"
      click_button "Adopt #{@pet_2.name}"

      fill_in "Search for Pets", with: "Chispa"
      click_button "Submit"
      click_button "Adopt #{@pet_4.name}"
    end

    it "can include multiple pets on the application" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_4.name)
    end

    it "has an input section during final submission to explain why user wants to adopt pet(s) and after submission removes option to add more pets" do
      visit "/applications/#{@application.id}"
      save_and_open_page
      fill_in "Application input", with: "I work remote and have the resources and financial ability to support an animal"
      save_and_open_page
      click_button "Submit This Application"
      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to_not have_content("In Progress")
      expect(page).to have_content("Pending")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_4.name)
      expect(page).to_not have_content("Search for Pets")
    end
  end

  ## USER STORY 7
  it "does not have a submit application button if there are no animals" do
    visit "/applications/#{@application_2.id}"
    expect(page).to_not have_content("Submit This Application")
  end

  # USER STORY 8
  it "displays partial matches for pet names in search" do
    visit "/applications/#{@application.id}"
    fill_in "Search for Pets", with: "Bare"
    click_button "Submit"
    click_button "Adopt"

    expect(page).to have_content(@pet_1.name)
  end

  # USER STORY 9
  it "displays case insensitive matches for pet names in search" do

    visit "/applications/#{@application.id}"
    fill_in "Search for Pets", with: "BARE-Y MANILOW"
    click_button "Submit"
    click_button "Adopt"

    expect(page).to have_content(@pet_1.name)
    
  end
end
