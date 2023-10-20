require "rails_helper"

RSpec.describe "As a visitor" do
  # 2. Application new Page
  describe "When I visit the pet index page" do
    it "Then I see a link to 'Start an Application'" do
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)

      visit "/pets"

      click_link("Start an Application")
      expect(page).to have_current_path("/applications/new") 
    end
  end
  describe "When I click this link" do
    it "Then I am taken to the new application page where I see a form" do
      visit "/applications/new"

      expect(page).to have_content("Pet Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip code")
      expect(find("form")).to have_content("Description")
    end
  end
  describe "When I fill in this form with my Name, Street Address, City, State, Zip Code, Description And I click submit" do
    it "I am taken to the new application's show page" do
      # @application = Application.new(name: "Jackkie",  street_address: "432 road st", city: "peoria", state: "az", description: "I love Dogs", application_status: "in progress")
      
      visit "/applications/new"

      fill_in("name", with: "Jackie")
      fill_in("street_address", with: "432 road st")
      fill_in("city", with: "Peoria")
      fill_in("state", with: "AZ")
      fill_in("zip_code", with: "85032")
      fill_in("description", with: "I love dogs")
      click_button("Submit Application")

      expect(current_path).to eq("/applications/#{Application.first.id}")
      
      expect(page).to have_content("Jackie")
      expect(page).to have_content("432 road st")
      expect(page).to have_content("Peoria")
      expect(page).to have_content("AZ")
      expect(page).to have_content("85032")
      expect(page).to have_content("I love dogs")
    end
  end
end