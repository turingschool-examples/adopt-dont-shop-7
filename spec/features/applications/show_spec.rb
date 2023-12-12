require "rails_helper"

RSpec.describe "applications show page", type: :feature do
  it "shows an application" do
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)
    application1 = pet1.applications.create!(
      name: "Fred Flintstone",
      address: "123 Main St, city: New York, state: NY, zip: 70117",
      description: "Worked with dinosaurs",
      status: "Accepted"
    )
    application1.pets << pet2

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(application1.name)
    expect(page).to have_content(application1.address)
    expect(page).to have_content(application1.description)
    expect(page).to have_content(application1.status)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)

    click_link("#{pet1.name}")
    expect(current_path).to eq("/pets/#{pet1.id}")

    visit "/applications/#{application1.id}"
    click_link("#{pet2.name}")
    expect(current_path).to eq("/pets/#{pet2.id}")
  end

  it "shows the an unsubmitted application with a search box to search for a pet name" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(application1.name)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_field("Search")

    fill_in "Search", with: "#{pet1.name}"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet1.name)
  end

  it  "after searching for pet, there's a button next to the pet name to add the pet to the application" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    fill_in "Search", with: "#{pet2.name}"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)

    click_button("Adopt this Pet")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)
  end

  it "has a submit application button for after pets are added to the application" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("Add a Pet to this Application")

    fill_in "Search", with: "#{pet2.name}"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)

    click_button("Adopt this Pet")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)

    fill_in "reason", with: "Worked with dinosaurs"
    expect(page).to have_button("Submit Application")

    click_button("Submit Application")

    expect(current_path).to eq("/applications/#{application1.id}")
# where it breaks
    expect(page).to have_content("Pending")
    expect(page).to have_content(pet2.name)
    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to_not have_content("Search Pets")
  end

  it "has a submit application button that is not visible with no pets added to application" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to_not have_button("Submit Application")
  end

  it "can search for pets with partial matches" do
  application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(application1.name)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_field("Search")

    fill_in "Search", with: "gar"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet1.name)

    fill_in "Search", with: "fi"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)
  end

  it "can search for pets, case insensitive" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
    pet2 = shelter.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)

    visit "/applications/#{application1.id}"

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(application1.name)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_field("Search")

    fill_in "Search", with: "GArfIeld"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet1.name)

    fill_in "Search", with: "fidO"
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{application1.id}")
    expect(page).to have_content(pet2.name)
  end
end
