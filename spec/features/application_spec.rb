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
  end

  describe "/application/new page" do
    it 'has fields to create new application' do
      visit "/applications/new"
      fill_in('application[name]', with: 'Jeremiah')
      fill_in('application[street_address]', with: "467 Corn Lane")
      fill_in('application[city]', with: "Lincoln")
      fill_in('application[state]', with: "Nebraska")
      fill_in('application[zip]', with: 68501)
      fill_in('application[description]', with: "I have a farm and lots of open space for them to play")
      fill_in('application[status]', with: "In Progress")
      click_button('submit')
      new_application = Application.last
      expect(current_path).to eq("/applications/#{new_application.id}")
      expect(page).to have_content(new_application.name)
      expect(page).to have_content(new_application.street_address)
      expect(page).to have_content(new_application.city)
      expect(page).to have_content(new_application.state)
      expect(page).to have_content(new_application.zip)
      expect(page).to have_content(new_application.description)
      expect(page).to have_content(new_application.status)
    end
  end
end
