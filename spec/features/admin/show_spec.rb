require "rails_helper"

RSpec.describe "admin application show page" do
  it "shows an approve button for " do
    dude = Applicant.create!(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    jane = Applicant.create!(name: "jane", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
    pet_2 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")
    application = PetsApplication.create!(applicant: dude, pet: pet_1, status: "Pending")
    application_1 = PetsApplication.create!(applicant: jane, pet: pet_2)

    visit "/admin/pets_applications/#{application.id}"

    expect(page).to have_content(dude.name)
    expect(page).to have_content(pet_1.name)

    expect(page).to have_button("Approve")
    click_button("Approve")
    expect(page).to have_content("Accepted")
    expect(page).to have_no_button("Approve")
  end

  it "shows an approve button for " do
    dude = Applicant.create!(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    jane = Applicant.create!(name: "jane", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
    pet_2 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")
    application = PetsApplication.create!(applicant: dude, pet: pet_1, status: "Pending")
    application_1 = PetsApplication.create!(applicant: jane, pet: pet_2)

    visit "/admin/pets_applications/#{application.id}"

    expect(page).to have_content(dude.name)
    expect(page).to have_content(pet_1.name)

    expect(page).to have_button("Reject")
    click_button("Reject")
    expect(page).to have_content("Rejected")
    expect(page).to have_no_button("Reject")
  end

  it "shows the status of an application on each page " do
    dude = Applicant.create!(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    jane = Applicant.create!(name: "jane", street_address: "11234 Jane Street", city: "Dallas", 
    state: "Texas", zip_code: "75248", description: "I love animals!")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
    pet_2 = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Barry")
    application = PetsApplication.create!(applicant: dude, pet: pet_1, status: "Pending")
    application_1 = PetsApplication.create!(applicant: jane, pet: pet_2)

    visit "/admin/pets_applications/#{application.id}"

    expect(page).to have_content("Application Status: Pending")
    expect(page).to have_content(dude.name)
    expect(page).to have_content(pet_1.name)

    expect(page).to have_button("Reject")
    click_button("Reject")
    expect(page).to have_content("Rejected")
    expect(page).to have_no_button("Reject")
  end
end

