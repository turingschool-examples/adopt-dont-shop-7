require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress") 
    @regan = Application.create!(name: "Regan Ocean", street_address: "46 N. Old York Road", city: "Willoughby", state: "OH", zip_code: "44094", description: "I like cats.", status: "Pending")
    @bruiser = @john.pets.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: @shelter.id)
    @bruno = @john.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter.id)
    @trixie = @trevor.pets.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: @shelter.id)
    @scrappy = @regan.pets.create!(name: "Scrappy", age: 1, breed: "Golden Retreiver", adoptable: true, shelter_id: @shelter.id)
  end

  describe 'Admin Application Show Page' do
    # User Story 12, Approving a Pet for Adoption
    it 'has a button to approve the application for a specific pet' do
      visit "/admin/applications/#{@john.id}"
      
      expect(page).to have_button("Approve Bruno")
      
      click_button("Approve Bruno")
      
      expect(current_path).to eq("/admin/applications/#{@john.id}")
      expect(page).to have_content("This Adoption has been Approved")
      expect(page).to have_content("Accepted")
      expect(page).to_not have_button("Approve Adoption")

    end

    # User Story 13, Rejecting a Pet for Adoption
    it 'allows pet rejection' do
      visit "/admin/applications/#{@john.id}"
      
      expect(page).to have_button("Reject Bruno")
      
      click_button("Reject Bruno")
      
      expect(current_path).to eq("/admin/applications/#{@john.id}")
      expect(page).to have_content("This Adoption has been Rejected")
      expect(page).to_not have_button("Reject Bruno")
    end

    # User Story 14, Approved/Rejected Pets on one Application do not affect other Applications
    it 'will not affect other pets' do
      visit "/admin/applications/#{@john.id}"
      @regan.add_pet(@bruno)

      expect(page).to have_button("Approve Bruno")
      
      click_button("Approve Bruno")

      visit "/admin/applications/#{@regan.id}"

      expect(page).to have_button("Reject Bruno")
      expect(page).to have_button("Approve Bruno")
    end

    # User Story 15, All Pets Accepted on an Application
    it 'approves all pets for an application' do
      visit "/admin/applications/#{@john.id}"
      expect(@john.pets).to eq([@bruiser, @bruno])
      # change this when we know what an approved button will say
      expect(page).to have_button("Approve Bruno")

      expect(page).to have_button("Approve Bruiser")
      click_button("Approve Bruno")
      save_and_open_page
      click_button("Approve Bruiser")

      expect(page).to have_content("Status: Accepted")
    end

    # User Story 16, One or More Pets Rejected on an Application
    it 'shows rejected if at least one pet is rejected' do
      visit "/admin/applications/#{@trevor.id}"
      # change this when we know what a rejected button will say
      click_button("Approve Adoption")
      click_button("Reject Adoption")

      expect(@trevor.status).to eq("Rejected")
    end

    # User Story 17, Application Approval makes Pets not adoptable
    it 'makes pets who are approved no longer adoptable' do
      visit "/admin/applications/#{@trevor.id}"
      click_button("Approve Adoption")
      visit "/pets/#{@bruiser.id}"

      expect(@bruiser.adoptable).to eq(false)
    end

    # User Story 18, Pets can only have one approved application on them at any time
    xit 'will not allow multiple applications to approve adoption' do
      @trevor.add_pet(@scrappy)
      visit "/admin/applications/#{@trevor.id}"
      # change this when we know what an approved button will say
      expect(page).to_not have_button(@scrappy.approve)
      expect(page).to have_content("Scrappy has been approved for adoption")
      expect(page).to have_button(@scrappy.reject)
    end
  end
end