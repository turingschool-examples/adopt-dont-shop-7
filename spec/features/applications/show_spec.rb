require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all of its attributes" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    application = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "Pending")

    application.pets << pet

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(pet.name)
    
    click_link("Scooby")

    expect(page).to have_current_path("/applications/pets/#{pet.id}")
  end
end