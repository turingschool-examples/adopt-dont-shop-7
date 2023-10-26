require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress") 
    @regan = Application.create!(name: "Regan Ocean", street_address: "46 N. Old York Road", city: "Willoughby", state: "OH", zip_code: "44094", description: "I like cats.", status: "In Progress")
    @bruiser = @john.pets.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: @shelter.id)
    @bruno = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter.id)
    @trixie = Pet.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: @shelter.id)
    @scrappy = Pet.create!(name: "Scrappy", age: 1, breed: "Golden Retreiver", adoptable: true, shelter_id: @shelter.id)
  end

  describe 'Admin Application Show Page' do
    # User Story 12, Approving a Pet for Adoption
    it 'has a button to approve the application for a specific pet' do
      visit "/applications/#{@trevor.id}"
      fill_in "search", with: "Bruno"
      click_button("Search")
      click_button("Adopt This Pet")
      fill_in("Why would you be a good home for these pets?", with: "I would like a dog")
      click_button("Submit")

      visit "/admin/applications/#{@trevor.id}"
      
      expect(page).to have_button("Approve Bruno")
      
      click_button("Approve Bruno")
      
      expect(current_path).to eq("/admin/applications/#{@trevor.id}")
      expect(page).to have_content("This Adoption has been Approved")
      expect(page).to have_content("Accepted")
      expect(page).to_not have_button("Approve Bruno")
    end

    # User Story 13, Rejecting a Pet for Adoption
    it 'allows pet rejection' do
      visit "/applications/#{@trevor.id}"
      fill_in "search", with: "Bruno"
      click_button("Search")
      click_button("Adopt This Pet")
      fill_in("Why would you be a good home for these pets?", with: "I would like a dog")
      click_button("Submit")

      visit "/admin/applications/#{@trevor.id}"
      
      expect(page).to have_button("Reject Bruno")
      
      click_button("Reject Bruno")
      
      expect(current_path).to eq("/admin/applications/#{@trevor.id}")
      expect(page).to have_content("This Adoption has been Rejected")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_button("Reject Bruno")
    end

    # User Story 14, Approved/Rejected Pets on one Application do not affect other Applications
    it 'will not affect other pets' do
      visit "/applications/#{@trevor.id}"
      fill_in "search", with: "Scrappy"
      click_button("Search")
      click_button("Adopt This Pet")
      fill_in("Why would you be a good home for these pets?", with: "I would like a dog")
      click_button("Submit")
      
      visit "/applications/#{@regan.id}"
      fill_in "search", with: "Scrappy"
      click_button("Search")
      click_button("Adopt This Pet")
      fill_in("Why would you be a good home for these pets?", with: "I would like a dog")
      click_button("Submit")
      
      visit "/admin/applications/#{@regan.id}"

      expect(page).to have_button("Approve Scrappy")
      
      click_button("Approve Scrappy")

      visit "/admin/applications/#{@trevor.id}"

      expect(page).to have_button("Reject Scrappy")
      expect(page).to have_button("Approve Scrappy")
    end
  end
end