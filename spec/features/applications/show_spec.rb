require "rails_helper"

RSpec.describe "the application show" do
  it "shows application and all it's attributes" do
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "shows application and search and return pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: shelter.id)
    
    visit "/applications/#{application.id}"
    fill_in( :search, with: 'Lobster')
    click_button('Search')

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(application.status)
  end

  it "shows application then search and select pet to adopt" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
  
    visit "/applications/#{application.id}"
    fill_in( :search, with: 'Lobster')
    click_button('Search')
    click_button('Adopt this Pet')

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(application.status)
  end

  it "shows application then search, select pet, and submit application" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
  
    visit "/applications/#{application.id}"
    fill_in( :search, with: 'Lobster')
    click_button('Search')
    click_button('Adopt this Pet')
    fill_in(:reason, with: "I don't eat animals")
    click_button('Submit Application')

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content("I don't eat animals")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content("Pending")
    expect(page).to have_no_content(:search)
  end

  it "cannot submit application with not pets selected" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
   
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_no_content("Submit Application")
  end

  it "shows application and search and returns pet, even if the name doesnt't exactly mathch" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "fluffy", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "fluff", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "mr. fluff", shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    fill_in( :search, with: 'fluff')
    click_button('Search')

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(application.status)
  end

  it "shows application and search and returns pet, even if the name doesn't match with capitalization" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Fluffy", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "FLUFF", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Mr.FlUfF", shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    fill_in( :search, with: 'fluff')
    click_button('Search')

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(application.status)
  end

  # it "updates the pet to approved after approving a pet" do
  #   shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  #   application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

  #   visit "/applications/#{application.id}"
  #   fill_in( :search, with: 'Lobster')
  #   click_button('Search')
  #   click_button('Adopt this Pet')
  #   fill_in(:reason, with: "I don't eat animals")
  #   click_button('Submit Application')

  #   visit "/admin/shelters/#{application.id}"
  #   click_button("Approve #{pet_2.name}")

  #   visit "/applications/#{application.id}"
  #   expect(page).to have_content("#{pet_2.name} Approved")
  # end

  # it "updates the pet to rejected after rejecting a pet" do
  #   shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  #   application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

  #   visit "/applications/#{application.id}"
  #   fill_in( :search, with: 'Lobster')
  #   click_button('Search')
  #   click_button('Adopt this Pet')
  #   fill_in(:reason, with: "I don't eat animals")
  #   click_button('Submit Application')

  #   visit "/admin/shelters/#{application.id}"
  #   click_button("Reject #{pet_2.name}")

  #   visit "/applications/#{application.id}"
  #   expect(page).to have_content("#{pet_2.name} Rejected")
  # end
end