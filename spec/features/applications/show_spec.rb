require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all of its attributes" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    application_1 = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "In Progress")
    pet = application_1.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.address)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.status)
    expect(page).to have_content("#{pet.name}")
    
    click_link("#{pet.name}")

    expect(page).to have_current_path("/pets/#{pet.id}")
  end
end