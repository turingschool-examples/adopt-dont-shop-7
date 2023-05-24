require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @application_1 = Application.create!(
      name: "Fredrich Longbottom",
      address: "1234 1st St",
      city: "Denver",
      state: "CO",
      zip: "80202",
      description_why: "I love creatures."
    )
    @application_2 = Application.create!(
      name: "Mike Tyson",
      address: "5678 2nd St",
      city: "Los Angeles",
      state: "CA",
      zip: "90210",
      description_why: "I love animalths."
    )

    @shelter_1 = Shelter.create!(
      foster_program: false,
      name: "Denver Animal Shelter",
      city: "Denver",
      rank: 1
    )
    @shelter_2 = Shelter.create!(
      foster_program: true,
      name: "Seattle Animal Shelter",
      city: "Seattle",
      rank: 2
    )
    @shelter_3 = Shelter.create!(
      foster_program: false,
      name: "Portland Animal Shelter",
      city: "Portland",
      rank: 3
    )
    @shelter_4 = Shelter.create!(
      foster_program: true,
      name: "Dallas Animal Shelter",
      city: "Dallas",
      rank: 4
    )

    @pet_1 = @shelter_1.pets.create!(
      adoptable: true,
      age: 3,
      breed: "Jack Russell Terrier",
      name: "Alphonso"
    )
    @pet_2 = @shelter_1.pets.create!(
      adoptable: true,
      age: 4,
      breed: "Husky",
      name: "Bailey"
    )
    @pet_3 = @shelter_1.pets.create!(
      adoptable: true,
      age: 2,
      breed: "Great Dane",
      name: "Charlie"
    )
    @pet_4 = @shelter_4.pets.create!(
      adoptable: true,
      age: 5,
      breed: "Golden",
      name: "Doug"
    )

    @pet_app_1 = PetApplication.create!(
      pet_id: @pet_1.id,
      application_id: @application_1.id
    )
    @pet_app_2 = PetApplication.create!(
      pet_id: @pet_4.id,
      application_id: @application_2.id
    )
    @pet_app_2.update(status: "Approved")


    visit "admin/shelters"
  end

  it "lists all the shelter names" do
    within "#all_shelters" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_3.name)
      expect(page).to have_content(@shelter_4.name)
    end
  end

  it "lists the shelters in reverse alphabetical order" do
    within "#all_shelters" do
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to appear_before(@shelter_4.name)
    end
  end

  it "has a section for shelters with pending applications" do
    within "#shelters_with_pending_apps" do
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
      expect(page).to_not have_content(@shelter_4.name)
    end
  end
end
