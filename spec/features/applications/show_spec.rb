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
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(application.status)
    end

    scenario 'US4 displays a section to add a pet to the application' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Search")

      fill_in "pet_name", with: "Zeus"
      click_button "Search"

      expect(page).to have_current_path("/applications/#{application.id}?pet_name=Zeus&commit=Search")
    end

    scenario 'US5 search for a pet by name to see matches and be able to adopt' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)

      visit "/applications/#{application.id}"

      expect(page).to have_content("Matching Pets:")

      fill_in "pet_name", with: "Zeus"
      click_button "Search"

      expect(page).to have_content("Zeus")
      expect(page).to_not have_content("Demeter")
      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      #probably need a wihthin block here
      expect(page).to have_content(application.pets.name)
    end

    scenario 'US8 search allows partial matches' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      
      visit "/applications/#{application.id}"

      fill_in "pet_name", with: "Zeu"
      click_button "Search"

      expect(page).to have_content("Zeus")
    end

    scenario 'US9 search is case insensitive' do
      application = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
      shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter.pets.create!(name: "zeus2", breed: "Great Dane", age: 3, adoptable: true)
      
      visit "/applications/#{application.id}"

      expect(page).to have_content("Matching Pets:")

      fill_in "pet_name", with: "zEus"
      click_button "Search"

      expect(page).to have_content("Zeus")
      expect(page).to have_content("zeus2")
    end
  end
end

