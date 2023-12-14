require "rails_helper"

RSpec.describe "the pets index" do
  it "lists all the pets with their attributes" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it "only lists adoptable pets" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it "displays a link to edit each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it "displays a link to delete each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/pets"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)

    visit "/pets"

    fill_in "Search", with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  before(:each) do
    @app1 = Application.create!(name: "Sam", address: "106 Chatsworth Circle", city: "Sugar Land", state: "TX", zipcode: "77456",description: "Needs a loyal friend", status: "In Progress")
    @app2 = Application.create!(name: "Poca", address: "7021 Garland", city: "Richmond", state: "TX", zipcode: "77407",description: "Needs a loyal friend", status: "In Progress")
    @app3 = Application.create!(name: "Prince", address: "4719 Rose Ambers Court", city: "Fresno", state: "TX", zipcode: "77545",description: "Wonderful companion on boring days", status: "Accepted")
    @app4 = Application.create!(name: "Taj", address: "22655 Briar Forest Drive", city: "Houston", state: "TX", zipcode: "77077",description: "Wonderful companion on boring days", status: "In Progress")
    
    @s1 = Shelter.create!(foster_program: true, name: "Dogtopia", city: "Houston", rank: 2)
    
    @pet1 = Pet.create!(name: "Buddy", adoptable: true, age: 5, breed: "Shiba", shelter_id: @s1.id)
    @pet2 = Pet.create!(name: "Jackie", adoptable: false, age: 1, breed: "Inu", shelter_id: @s1.id)
    
    @pet_app1 = PetApplication.create!(application: @app1, pet: @pet2)
    @pet_app2 = PetApplication.create!(application: @app2, pet: @pet1)
  end 

  # US 2 Part 1
  describe "As a visitor" do
    describe "when I visit /pets index page" do
      it "displays a form to create a new application" do
        # As a visitor
        # When I visit the pet index page
        # Then I see a link to "Start an Application"
        # When I click this link
        # Then I am taken to the new application page where I see a form

        visit "/pets"

        expect(page).to have_link("Start an Application")

        click_link("Start an Application")

        expect(current_path).to eq("/applications/new")

        expect(page).to have_content("New Application Form")
        fill_in "Name", with: "Chris"
        fill_in "Street Address", with: "2900 Grimes Ranch Road"
        fill_in "City", with: "Austin"
        fill_in "State", with: "TX"
        fill_in "zipcode", with: "70732"
        fill_in "description", with: "Needs an amazing buddy"
        click_button "Submit"

        new_app = Application.last
        
        expect(current_path).to eq("/applications/#{new_app.id}")
        expect(page).to have_content("Chris")
        expect(page).to have_content("2900 Grimes Ranch Road")
        expect(page).to have_content("Needs an amazing buddy")
        expect(page).to have_content("In Progress")
      end
    end
  end
end