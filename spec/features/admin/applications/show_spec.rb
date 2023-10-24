require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress") 
    @regan = Application.create!(name: "Regan Ocean", street_address: "46 N. Old York Road", city: "Willoughby", state: "OH", zip_code: "44094", description: "I like cats.", status: "Pending")
    @bruiser = Pet.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: @shelter.id)
    @bruno = @john.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter.id)
    @trixie = Pet.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: @shelter.id)
    
  end

  describe 'Admin Application Show Page' do
    # User Story 12, Approving a Pet for Adoption
    it 'has a button to approve the application for a specific pet' do
      visit "/admin/applications/#{@john.id}"
      
      expect(page).to have_button("Approve Adoption")
      
      click_button("Approve Adoption")
      
      expect(current_path).to eq("/admin/applications/#{@john.id}")
      expect(page).to have_content("This Adoption has been Approved")
      expect(page).to_not have_button("Approve Adoption")
      expect(@john.status).to eq("Accepted")
      expect(@bruno.adoptable).to eq(false)
    end
  end
end