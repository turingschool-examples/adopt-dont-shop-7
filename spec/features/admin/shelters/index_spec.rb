require "rails_helper"

RSpec.describe "Admin shelters index" do
  describe "when I visit admin/shelter index" do
    it "displays all shelters listed in reverse alphabetical order by name" do
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

      visit "/admin/shelters"

      expect(shelter_2.name).to appear_before(shelter_3.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)

    end

    it "has a section for shelters with pending applications" do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters With Pending Applications")
    end

    it "displays the name of every shelter that has a pending application" do 
      shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "Pending")
      
      # visit "/applications/#{application_1.id}"
      # fill_in "search", with: "Scrappy"
      # click_button "Search"
      # click_button "Adopt this Pet"
      # fill_in "application_description", with: "I love dogs"
      # click_button "Submit"
      # save_and_open_page
      
      shelter_1.applications << application_1
      visit "/admin/shelters"

      save_and_open_page
      
      expect(shelter_1.applications.first).to eql(application_1)
      expect(application_1.status).to eql("Pending")
      expect(page).to have_content(shelter_1.name)
      # expect(page).not_to have_content(shelter_2.name)
      # expect(page).not_to have_content(shelter_3.name)

    end
  end
end