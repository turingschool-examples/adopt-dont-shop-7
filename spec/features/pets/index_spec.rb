require "rails_helper"

RSpec.describe "the pets index" do 
  before(:each) do 
    @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Rocky", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bullwinkle", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: "saint bernard", name: "Boris", shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Susan", 
      street: "7654 Clover St", 
      city: "Denver", 
      state: "CO", 
      zip: "80033", 
      descr: "I love animals and am lonely")
   
    @pet_1_app =PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id)
    @app_1.pets << @pet_2
    @app_1.pets << @pet_3
   end

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
    # pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    # pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
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

  it "has a link to start an application" do 
    visit "/pets"

    expect(page).to have_link("Start an Application")
    
    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("New Application")

    expect(page).to have_content("Name:")
    expect(page).to have_field(:name)
    expect(page).to have_content("Street address:")
    expect(page).to have_field(:street)
    expect(page).to have_content("City:")
    expect(page).to have_field(:city)
    expect(page).to have_content("State:")
    expect(page).to have_field(:state)
    expect(page).to have_content("Zip code:")
    expect(page).to have_field(:zip)
    expect(page).to have_content("What makes me a good owner:")
    expect(page).to have_field(:good_owner)

    fill_in(:name, with: "Matt")
    fill_in(:street, with: "2636 Vrain St.")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "CO")
    fill_in(:zip, with: "80212")
    fill_in(:good_owner, with: "B/c I'm awesome!")

    expect(page).to have_button("Submit")

    click_button "Submit" 
    
    expect(page).to have_content("Matt")
    expect(page).to have_content("2636 Vrain St.")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("80212")
    expect(page).to have_content("B/c I'm awesome!")
    expect(page).to have_content("In Progress")
  end

end
