require "rails_helper"

RSpec.describe "admin_applications show" do

  it "accept application for pet" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    # We can pull the entire test if we want to set status the right way, but I just hard coded it
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)

    visit "/admin/shelters/#{application.id}"
    click_button("Approve #{pet_1.name}")

    expect(page).to have_content("Approved")
  end

  it "reject application for pet" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    # We can pull the entire test if we want to set status the right way, but I just hard coded it
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_1.id)

    visit "/admin/shelters/#{application.id}"
    click_button("Reject #{pet_1.name}")

    expect(page).to have_content("Rejected")
  end

  it "applications don't effect each other" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application_1 = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    application_2 = Application.create(name:"Tim", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    # We can pull the entire test if we want to set status the right way, but I just hard coded it
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    
    application_1.add_pet(pet_1.id)
    application_2.add_pet(pet_1.id)

    visit "/admin/shelters/#{application_1.id}"
    click_button("Approve #{pet_1.name}")

    
    visit "/admin/shelters/#{application_2.id}"
    expect(page).to have_content("Approve #{pet_1.name}")
  end
end