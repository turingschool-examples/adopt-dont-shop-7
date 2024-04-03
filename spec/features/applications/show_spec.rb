require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all it's attributes" do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "Pending"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = application.pets.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )
    pet_2 = application.pets.create!(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: shelter.id
    )
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    
    within "#application_pets" do
      expect(page).to have_content("Lucille Bald")
      expect(page).to have_content("Lobster")

      expect(page).to have_link("Lucille Bald")
      expect(page).to have_link("Lobster")

      click_on "Lucille Bald"
    end
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it 'can search for pets on an application show page if that application has not been submitted' do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )

    visit "/applications/#{application.id}"

    expect(page).to have_field("Search")

    fill_in(:search, with: "Lucille Bald")
    click_button("Search")

    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content("Lucille Bald")
  end

  it "Adds a Pet to an Application" do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )

    visit "/applications/#{application.id}"

    fill_in(:search, with: "Lucille Bald")
    click_button("Search")

    expect(page).to have_content("Lucille Bald")
    expect(page).to have_button("Adopt this pet")
    click_button("Adopt this pet")

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pets:")
    within "#application_pets" do
      expect(page).to have_content("Lucille Bald")
    end
  end

  it 'Submits an application with the chosen pets and changes its status to pending' do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )
    pet_2 = Pet.create!(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: shelter.id
      )
    pet_3 = Pet.create!(
      adoptable: false,
      age: 2,
      breed: "saint bernard",
      name: "Beethoven",
      shelter_id: shelter.id
      )

    visit "/applications/#{application.id}"

    fill_in(:search, with: "Lucille Bald")
    click_button("Search")

    click_button("Adopt this pet")

    fill_in(:search, with: "Lobster")
    click_button("Search")

    click_button("Adopt this pet")

    within "#submit_application" do
      expect(page).to have_field("Description")

      fill_in("Description", with: "I love the name Lobster!")

      expect(page).to have_button("Submit")
      click_button("Submit")
    end

    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content("Status: Pending")

    within "#application_pets" do
      expect(page).to have_content("Lucille Bald")
      expect(page).to have_content("Lobster")
    end

    expect(page).to_not have_field("Search")
  end


  it "has no pets" do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )
    pet_2 = Pet.create!(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: shelter.id
      )
    pet_3 = Pet.create!(
      adoptable: false,
      age: 2,
      breed: "saint bernard",
      name: "Beethoven",
      shelter_id: shelter.id
      )

    visit "/applications/#{application.id}"

    expect(page).to_not have_button("Submit")

    fill_in("Search", with: "Bald")
    click_on("Search")
    click_on("Adopt this pet")

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_button("Submit")
  end

  it 'can search for partial matches for pet names' do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )

    visit "/applications/#{application.id}"

    fill_in(:search, with: "Bald")
    click_button("Search")

    expect(page).to have_content("Lucille Bald")
  end

  it 'can search for case insensitive matches for pet names' do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: shelter.id
    )

    visit "/applications/#{application.id}"

    fill_in(:search, with: "LuCiLlE")
    click_button("Search")

    expect(page).to have_content("Lucille Bald")
  end
end
