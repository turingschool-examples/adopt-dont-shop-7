require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all of its attributes" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    application_1 = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "Pending", pet_id: pet.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.address)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.status)
    expect(page).to have_content(application_1.pet_id)
  end
end