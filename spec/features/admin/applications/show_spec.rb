require "rails_helper"

RSpec.describe "Admins Shelter Index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(name: "Luis Aparicio", street_address: "7511 James St", city: "Menasha", state: "WI", zipcode: "54952", description: "I love pets!", application_status: "In Progress")
    @application_2 = Application.create!(name: "test", street_address: "test James St", city: "ena", state: "az", zipcode: "52332", description: "I love2 pets!",application_status: "In Progress")
    @application_3 = Application.create!(name: "Faisal", street_address: "12907 conquistador", city: "Spring Hill", state: "FL", zipcode: "34610", description: "I love pets")
    @application_4 = Application.create!(name: "Barry", street_address: "1234 Oxford St", city: "OKC", state: "OK", zipcode: "73122", description: "I love animals!",application_status: "Pending")
    @application_5 = Application.create!(name: "Larry David", street_address: "8888 Malibu Dr", city: "LA", state: "CA", zipcode: "10022", description: "I kind of like animals",application_status: "Pending")
  
    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id, pet_reason: "N/A")
    @application_pet_2 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_3.id, pet_reason: "N/A")
    @application_pet_3 = ApplicationPet.create!(application_id: @application_5.id, pet_id: @pet_4.id, pet_reason: "N/A")
  
  end

  # User Story 12
  it "has a button to approve an application for a specific pet" do
    visit "/admin/applications/#{@application_4.id}"

    expect(page).to have_content("Lucille Bald")
    expect(page).to have_button("Approve")
    click_button("Approve")

    expect(current_path).to eq("/admin/applications/#{@application_4.id}")
    expect(page).to have_content("Pet Approved")
  end
end

