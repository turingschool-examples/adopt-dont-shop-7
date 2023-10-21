require "rails_helper"

RSpec.describe "the application show" do

  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", description: "Gimme", status: "Pending")
    @application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", description: "5 solid meals a day", status: "Rejected")
    @application3 = Application.create!(name: "Billy", full_address: "777 Circle Court, Houston, TX 77000", description: "Best Day Every Day", status: "In Progress")
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @pet_4 = Pet.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter.id)
    @pet_5 = Pet.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter.id)
    @pet_6 = Pet.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter.id)

    @application1.pets << @pet_1 
    @application1.pets << @pet_2 
    @application2.pets << @pet_2 
    @application2.pets << @pet_3 
  end

  it "shows the application and all it's attributes" do

    visit "/applications/#{@application1.id}"

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.full_address)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

  end

  it "Can search and returns names to add pets to application" do
    visit "/applications/#{@application2.id}"

    expect(page).to have_content(@application2.name)
    expect(page).to have_content(@application2.full_address)
    expect(page).to have_content(@application2.description)
    expect(page).to have_content(@application2.status)

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")

    fill_in(:search, with: "Clawdia")
    expect(page).to_not have_content("Results:")
    click_button("Search")

    expect(current_path).to eq("/applications/#{@application2.id}")
    expect(page).to have_content("Results:")
    expect(page).to have_content("Clawdia")
  end

  it "Can add pets found by search result to an application" do
    visit "/applications/#{@application2.id}"
    expect(page).to_not have_content("Clawdia")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    expect("Add a Pet to this Application").to appear_before("Clawdia")
    expect("Clawdia").to appear_before("Adopt this Pet")
    # click_button("Adopt this Pet")
    click_link("Adopt this Pet")
    expect(current_path).to eq("/applications/#{@application2.id}")
    expect("Clawdia").to appear_before("Add a Pet to this Application")
  end

  it "Cannot add a pet that has already been added" do
    visit "/applications/#{@application2.id}"
    expect(page).to_not have_content("Already on Application")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    # click_button("Adopt this Pet")
    click_link("Adopt this Pet")
    expect(page).to_not have_content("Already on Application")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    click_link("Adopt this Pet")
    expect(page).to have_content("Already on Application")

  end
end
