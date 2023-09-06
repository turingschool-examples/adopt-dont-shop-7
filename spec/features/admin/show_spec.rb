equire "rails_helper"

RSpec.feature "Approving a Pet for Adoption", type: :feature do
  describe "Visitor approves a pet for adoption" do
    visit "/admin/applications/#{applcation.id}"
    shelter = Shelter.create!(
      foster_program: true,
      name: "The Shelter",
      city: "Happy City",
      rank: 1
    )

    shelter_2 = Shelter.create!(
      foster_program: false,
      name: "A Shelter",
      city: "A City",
      rank: 5
    )

    pet_1 = shelter.pets.create!(
      adoptable: true,
      age: 3,
      breed: "orange cat",
      name: "Cheesecake"
    )

    application = Application.create!(
      name: "John Smith",
      street_address: "1234 Lane Street",
      city: "Happy City",
      state: "CO",
      zip_code: "80111",
      owner_description: "I want an animal",
      status: "Pending"
   
      pets = Application.find(:id).pets

    pets.each do |pet|
      expect(page).to have_button("Approve #{pet.name}")
      click_button("Approve #{pet.name}")

      expect(page).to have_no_button("Approve #{pet.name}")
      expect(page).to have_css(".approved-indicator", text: "#{pet.name} has been approved")
    end
  end
end
