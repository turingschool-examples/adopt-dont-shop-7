require "rails_helper"

RSpec.describe "application" do
  before :each do
    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Fake St",
      city: "Lander",
      state: "WY",
      zip: 82520,
      description: "I am loving and attentive.",
      status: "Accepted")
    @application_2 = Application.create!(
      name: "Sarah",
      street_address: "321 Faux Ln",
      city: "Salt Lake City",
      state: "UT",
      zip: 84104,
      description: "I live in a small apartment but am lonely so want a pet.",
      status: "In Progress")

    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @pet_application_1 = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_application_2 = PetApplication.create!(pet: @pet_2, application: @application_1)
  end
  it "displays a link to all pets" do
    visit "/"
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path("/pets")
  end

  it "displays a link to all shelters" do
    visit "/"

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path("/shelters")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinary offices" do
    visit "/"

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path("/veterinary_offices")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinarians" do
    visit "/"

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path("/veterinarians")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  describe "application show page" do
    it "displays an applicant's name and other attributes" do
      visit "/applications/#{@application_1.id}"
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street_address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@application_1.status)

    end

    it "has a link to each pets show page if you click their name" do
      visit "/applications/#{@application_1.id}"

      click_on(@pet_1.name)
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      visit "/applications/#{@application_1.id}"
      click_on(@pet_2.name)
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end

    it "has a means to search for pets to add to an application if unsubmitted" do
      visit "/applications/#{@application_2.id}"
      expect(page).to_not have_content("Ann")

      fill_in(:pet_name, with: 'Ann')
      click_button('Search Pets')

      expect(current_path).to eq("/applications/#{@application_2.id}")
      expect(page).to have_content("Ann")

      visit "/applications/#{@application_1.id}"
      expect(page).to_not have_content("Search Pets")
    end
  end

  describe "/application index page" do
    it "shows each application and when it was created" do
      visit "/applications"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.created_at)
      expect(page).to have_content(@application_2.name)
      expect(page).to have_content(@application_2.created_at)
    end
  end

  describe "/application/new page" do
   it 'has fields to create new application' do
      visit "/applications/new"

      fill_in('Name', with: 'Jeremiah')
      fill_in('Street address', with: "467 Corn Lane")
      fill_in('City', with: "Lincoln")
      fill_in('State', with: "Nebraska")
      fill_in('Zip', with: 68501)
      fill_in('Description', with: "I have a farm and lots of open space for them to play")
      click_button('Start Application')
      new_application = Application.last
      expect(current_path).to eq("/applications/#{new_application.id}")

      expect(page).to have_content(new_application.name)
      expect(page).to have_content(new_application.street_address)
      expect(page).to have_content(new_application.city)
      expect(page).to have_content(new_application.state)
      expect(page).to have_content(new_application.zip)
      expect(page).to have_content(new_application.description)
      expect(page).to have_content("In Progress")
    end

    it 'will return a form not completed error if all forms arent filled out' do
      visit "/applications/new"

      fill_in('Name', with: 'Jeremiah')
      fill_in('Street address', with: "467 Corn Lane")
      fill_in('State', with: "Nebraska")
      fill_in('Zip', with: 68501)

      click_button('Start Application')
      save_and_open_page
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("City can't be blank")
    end
  end
end
