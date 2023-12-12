require "rails_helper"

RSpec.describe "the admin applications show page", type: :feature do
  describe "when logged in as an admin" do
    it "lists all the pets on the application" do
      # I am not making Applications and I am too tired to troubleshoot further
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)
      pet_2 = shelter_2.pets.create!(name: "fido", breed: "mutt", adoptable: true, age: 2)
      application = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")

      application.pets << [pet_1, pet_2]

      visit "/admin/applications/#{application.id}"

      expect(page).to have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)

      click_button "Approve #{pet_1.name}!"
      expect(current_path).to eq("/admin/applications/#{application.id}")

      expect(page).to_not have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
    end
  end
end
