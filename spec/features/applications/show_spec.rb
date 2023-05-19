require "rails_helper"

RSpec.describe "the application show page" do 
  it "shows the application and all of its attributes" do
    application_1 = Application.create!(name: "John Doe", address: "123 Sesame St,Denver, CO 8020", description: "I have big hands.", application_status: "In Progress")
    shelter = Shelter.create!(foster_program: true, name: "Public Shelter", city: "Denver", rank: 1)
    buddy = shelter.pets.create!(adoptable: true, age: 3, breed: "Cockapoo", name: "Buddy Howly")
    
    pa1 = PetApplication.create!(application: application_1, pet: buddy)
    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_link("Buddy Howly")
    expect(page).to have_content(application_1.address)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    save_and_open_page
  end
end

