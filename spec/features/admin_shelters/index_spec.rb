require "rails_helper"

RSpec.describe "the pets index" do
  it "Lists shelters in decending order" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Ford shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Zeta shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit '/admin/shelters'

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_1.name)
  end

  it "Shelters with pending orders should show it" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Bobs shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "Pending")
    # We can pull the entire test if we want to set status the right way, but I just hard coded it
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
    pet_1 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Bacon", shelter_id: shelter_2.id)
    application.add_pet(pet_2.id)

    visit '/admin/shelters'

    expect(page).to have_content("Pending")
    
  end
end