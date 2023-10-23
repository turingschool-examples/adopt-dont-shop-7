require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: [], status: "Pending")  
    @regan = Application.create!(name: "Regan Ocean", street_address: "46 N. Old York Road", city: "Willoughby", state: "OH", zip_code: "44094", description: "I like cats.", pet_names: [], status: "Approved")
    @bruiser = @trevor.pets.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: @shelter.id)
    @bruno = @john.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter.id)
    @trixie = @trevor.pets.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: @shelter.id)
    @scrappy = @regan.pets.create!(name: "Scrappy", age: 1, breed: "Golden Retreiver", adoptable: true, shelter_id: @shelter.id)
  end

  describe 'Admin Application Show Page' do
    # User Story 12, Approving a Pet for Adoption
    it 'has a button to approve the application for a specific pet' do
      visit "/admin/applications/#{@john.id}"
    
      expect(page).to have_content("Approve Adoption")

      click_button(@bruno.id)

      expect(current_path).to eq("/admin/applications/#{@john.id}")
      expect(@john.status).to eq("Approved")
      expect(@bruno.adoptable).to eq(false)
      expect(page).to_not have_content("Adopt This Pet")

      expect(page).to have_content("This Adoption has been Approved")
    end

    # User Story 15, All Pets Accepted on an Application
    it 'approves all pets for an application' do
      visit "/admin/applications/#{@trevor.id}"
      # change this when we know what an approved button will say
      click_button(@bruiser.id)
      click_button(@trixie.id)

      expect(@trevor.status).to eq("Approved")
    end

    # User Story 16, One or More Pets Rejected on an Application
    it 'shows rejected if at least one pet is rejected' do
      visit "/admin/applications/#{@trevor.id}"
      # change this when we know what a rejected button will say
      click_button(@bruiser.id)
      click_button(@trixie.id)

      expect(@trevor.status).to eq("Rejected")
    end

    # User Story 17, Application Approval makes Pets not adoptable
    it 'makes pets who are approved no longer adoptable' do
      visit "/admin/applications/#{@trevor.id}"
      click_button(@bruiser.id)
      visit "/pets/#{@bruiser.id}"

      expect(@bruiser.adoptable).to eq(false)
    end

    # User Story 18, Pets can only have one approved application on them at any time
    it 'will not allow multiple applications to approve adoption' do
      @trevor.add_pet(@scrappy)
      visit "/admin/applications/#{@trevor.id}"
      # change this when we know what an approved button will say
      expect(page).to_not have_button(@scrappy.approve)
      expect(page).to have_content("Scrappy has been approved for adoption")
      expect(page).to have_button(@scrappy.reject)
    end
  end
end