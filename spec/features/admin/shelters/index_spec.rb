require "rails_helper"

RSpec.describe "the admin index" do
  it "shows a list of shelters in reverse alphabetical order" do
    shelter_1 = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/admin/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_2.name)
    expect(shelter_3.name).to appear_before(shelter_1.name)
    expect(shelter_1.name).to appear_before(shelter_2.name)
  end

  it "shows a list of shelters with pending applications" do
    shelter = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: "#{shelter.id}")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: "#{shelter.id}")
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: "#{shelter_2.id}")
    pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: "#{shelter_2.id}")


    applicant_1 = Applicant.create(name: "George", street_address: "1421 W Mockingbird Ln", city: "Boulder", state: "Texas", zip_code: "23452", description: "I love animals!")
    applicant_2 = Applicant.create(name: "Jasmine", street_address: "1421 W Mockingbird Ln", city: "Boulder", state: "Texas", zip_code: "23452", description: "I love animals!")

    PetsApplication.create!(applicant: applicant_1, pet: pet_1 )
    PetsApplication.create!(applicant: applicant_1, pet: pet_3 )

    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter_2.name)

  end
end

require "rails_helper"

RSpec.describe "the admin index" do
  it "shows a list of shelters in reverse alphabetical order" do
    shelter_1 = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/admin/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_2.name)
    expect(shelter_3.name).to appear_before(shelter_1.name)
    expect(shelter_1.name).to appear_before(shelter_2.name)
  end

  it "shows a list of shelters with pending applications" do
    shelter = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: "#{shelter.id}")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: "#{shelter.id}")
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: "#{shelter_2.id}")
    pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: "#{shelter_2.id}")


    applicant_1 = Applicant.create(name: "George", street_address: "1421 W Mockingbird Ln", city: "Boulder", state: "Texas", zip_code: "23452", description: "I love animals!")
    applicant_2 = Applicant.create(name: "Jasmine", street_address: "1421 W Mockingbird Ln", city: "Boulder", state: "Texas", zip_code: "23452", description: "I love animals!")

    PetsApplication.create!(applicant: applicant_1, pet: pet_1 )
    PetsApplication.create!(applicant: applicant_1, pet: pet_3 )

    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter_2.name)

  end
end