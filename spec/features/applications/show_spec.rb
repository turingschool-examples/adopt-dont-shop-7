require "rails_helper"

RSpec.feature "the application show" do
  describe 'when visiting /applications/:id/show' do
    scenario 'US1 displays all application info' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter1.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter1.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
      application.pets << pet1
      application.pets << pet2


      visit "/applications/#{application.id}"

      expect(page).to have_content(application.applicant_name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content("Zeus")
      expect(page).to have_content("Demeter")
      expect(page).to have_content(application.status)
    end

    scenario 'US 4 displays a section to add a pet to the application' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)

      visit "/applications/#{application.id}"

      expect(page).to_not have_content("Zeus")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Submit")

      fill_in "pet_name", with: "Zeus"
      click_button "Submit"

      expect(page).to have_content("Zeus")
    end
  end
end

