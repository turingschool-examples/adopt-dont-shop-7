require "rails_helper"

RSpec.describe "the shelter show" do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.rank)
    expect(page).to have_content(shelter.city)
  end

  it "shows the number of pets associated with the shelter" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter.pets.create(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

    visit "/shelters/#{shelter.id}"

    within ".pet-count" do
      expect(page).to have_content(shelter.pets.count)
    end
  end

  it "allows the user to delete a shelter" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    click_on("Delete #{shelter.name}")

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(shelter.name)
  end

  it "displays a link to the shelters pets index" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: true, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_link("All pets at #{shelter.name}")
    click_link("All pets at #{shelter.name}")

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end

  it "Will only show shelter name and address when visited by admin" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)


    visit "/admin/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to_not have_content(shelter_1.foster_program)
    expect(page).to_not have_content(shelter_1.rank)
  end

  it "When visited by an admin, there is an action required section that shows a list of pets with pending application that have not been marked approved or rejected" do
    #Applications are automatically rejected when any pet is rejected so this will not be tested
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "one eyed cats!!", status: "Pending")
    application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I woudln't", status: "Pending")
    pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    pet_2 = shelter_3.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    pet_4 = shelter_3.pets.create(name: "Ann", breed: "sphynx", age: 8, adoptable: true)
    pet_5 = shelter_3.pets.create(name: "QWERTY", breed: "sphynx", age: 8, adoptable: true)
    pet_6 = shelter_3.pets.create(name: "Ballistic Missile", breed: "sphynx", age: 8, adoptable: true)
    application1.pets << pet_1 
    application1.pets << pet_2 
    application2.pets << pet_2 
    application2.pets << pet_3
    application2.pets << pet_4
    application2.pets << pet_5
    application2.pets << pet_6

    visit "/admin/shelters/#{shelter_1.id}"
    expect(page).to have_content("Action Required")
    expect(page).to have_content("Mr. Pirate")
    expect(page).to_not have_content("Clawdia")
    
    visit "/admin/shelters/#{shelter_2.id}"
    expect(page).to have_content("Action Required")
    expect(page).to_not have_content("Mr. Pirate")
    
    visit "/admin/shelters/#{shelter_3.id}"
    expect(page).to have_content("Action Required")
    expect(page).to have_content("Clawdia")
    expect(page).to have_content("Lucille Bald")
    expect(page).to have_content("Ann")
    expect(page).to have_content("QWERTY")
    expect(page).to have_content("Ballistic Missile")
    
    visit "admin/applications/#{application1.id}"
    click_button("Approve Application for #{pet_2.name}")
    
    visit "/admin/shelters/#{shelter_3.id}"
    expect(page).to have_content("Clawdia")
    
    visit "admin/applications/#{application1.id}"
    click_button("Approve Application for #{pet_1.name}")
    
    visit "/admin/shelters/#{shelter_1.id}"
    expect(page).to have_content("Action Required")
    expect(page).to_not have_content("Mr. Pirate")
    
    visit "/admin/shelters/#{shelter_3.id}"
    expect(page).to have_content("Action Required")
    expect(page).to_not have_content("Clawdia")
    expect(page).to have_content("Lucille Bald")
    expect(page).to have_content("Ann")
    expect(page).to have_content("QWERTY")
    expect(page).to have_content("Ballistic Missile")
    
  end
end
