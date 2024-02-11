require 'rails_helper'

RSpec.describe 'Admin Shelters Index Page' do
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
  it 'shows all shelters in the system in reverse alphabetical order by name' do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    
    visit '/admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

#   As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelters with Pending Applications"
# And in this section I see the name of every shelter that has a pending application
  it 'should have a section called Shelters with Pending Applications' do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow")
    pet_2 = shelter_2.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
    pet_3 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester")
    pet_4 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna")

    application_1 = Application.create!(name: "Test 1", street_address: "123 street", city: "denver", state: "co", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")
    application_2 = Application.create!(name: "Test 2", street_address: "12323 street", city: "lakewood", state: "ca", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")

    application_pet_1 = ApplicationPet.create!(application_id: application_1.id, pet_id: pet_1.id)
    application_pet_2 = ApplicationPet.create!(application_id: application_1.id, pet_id: pet_2.id)

    visit "/admin/shelters"

    within"#pending_apps" do
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(page).not_to have_content(shelter_3.name)
    end
  end
end