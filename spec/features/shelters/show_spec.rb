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
  
  it "Has a statistics section showing average age of all pets" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    visit "/admin/shelters/#{shelter_1.id}"
    
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to_not have_content(shelter_1.foster_program)
    expect(page).to_not have_content(shelter_1.rank)

    within("div#stats") do
      expect(page).to have_content("Statistics")
      expect(page).to have_content("Average Pet Age:")
    end
  end

  it "Has a statistics section showing the count of pets at a shelter" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    visit "/admin/shelters/#{shelter_1.id}"
    
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to_not have_content(shelter_1.foster_program)
    expect(page).to_not have_content(shelter_1.rank)

    within("div#stats") do
      expect(page).to have_content("Shelter Statistics")
      expect(page).to have_content("Average Pet Age: #{shelter_1.pets.average(:age)}")
      expect(page).to have_content("Adoptable Pet Count: 3")
    end
  end

  it "Has a statistics section showing the number of pets from this shelter that have been adopted." do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Approved")
    application1.pets << pet_1 
    application1.pets << pet_2 

    # require 'pry'; binding.pry
    visit "/admin/shelters/#{shelter_1.id}"
    
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to_not have_content(shelter_1.foster_program)
    expect(page).to_not have_content(shelter_1.rank)

    within("div#stats") do
      expect(page).to have_content("Shelter Statistics")
      expect(page).to have_content("Average Pet Age: #{shelter_1.pets.average(:age)}")
      expect(page).to have_content("Adoptable Pet Count: 4")
      expect(page).to have_content("Pets who have found a home!: ")
    end
  end
end
