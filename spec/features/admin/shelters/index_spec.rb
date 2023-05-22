require "rails_helper"

RSpec.describe "admin index page" do
  describe "/admin/shelters" do
    it "All shelters listed in reverse alphabetical order by name" do
      test_data
      visit "/admin/shelters"

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    end

    it "shows applications with pending applications in each shelter" do
      @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: true, rank: 9)
      @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: true, rank: 5)
      @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: false, rank: 10)

      @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
      @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")

      @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")

      @pet_5 = @shelter_3.pets.create!(adoptable: true, age: 4, breed: "tabby", name: "Pepper")

      @application_1 = Application.create!(name: "Bob", street_address: "1234 Southeast St",
      city: "San Francisco", state: "CA", zip_code: 12345,
      description: "Wants a dog", status: "Pending")
      @application_2 = Application.create!(name: "Sally", street_address: "4321 Bridge Way",
      city: "San Francisco", state: "CA", zip_code: 54321,
      description: "Would like a siamese cat", status: "Pending")

      @application_3 = Application.create!(name: "Fred", street_address: "376 Monroe St",
      city: "Los Angeles", state: "CA", zip_code: 67890,
      description: "My wife really wants this cat", status: "In Progress")
      @application_5 = Application.create!(name: "Jimbo", street_address: "45865 Turnaround St",
      city: "NYC", state: "NY", zip_code: 84930,
      description: "I want a big ol dog", status: "Pending")

      PetApplication.create!(pet: @pet_1, application: @application_2)
      PetApplication.create!(pet: @pet_2, application: @application_1)

      PetApplication.create!(pet: @pet_3, application: @application_5)

      PetApplication.create!(pet: @pet_5, application: @application_3)
      visit "/admin/shelters"

      within "#pending_apps" do
      save_and_open_page
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content("Aurora shelter")
        expect(page).to have_content("RGV animal shelter")
        expect(page).to_not have_content("Fancy pets of Colorado")
      end
    end
  end
end