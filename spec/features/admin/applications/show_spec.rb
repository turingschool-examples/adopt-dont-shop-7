require 'rails_helper'

RSpec.describe "Admin Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")
    @application_3 = Application.create!(name: "Marianne Bird", street_address: "3254 Love Ave", city: "Las Vegas", state: "NM", zip_code: 87701, description: "I want to get another pet for my dog who's getting older", status: "In Progress")
    @application_4 = Application.create!(name: "Matthew Gorzy", street_address: "1030 18th Ave", city: "Las Cruces", state: "NM", zip_code: 87718, description: "I'm really outdoorsy and want a partner in crime", status: "In Progress")


    @petapp_1 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_3.id)
    @petapp_2 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_5.id)
    @petapp_3 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_3.id)
    @petapp_4 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_5.id)
    @petapp_5 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_4.id)
    @petapp_6 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_4.id)

  end

  describe '#Managing Approvals for Pending Applications' do
    ## USER STORY 12
      it 'when viewing the admin application show page, there are buttons to approve the application for each pet' do
        visit "/admin/applications/#{@application.id}"
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_content(@pet_5.name)
        expect(page).to have_content("Approve #{@pet_3.name}")
        expect(page).to have_content("Approve #{@pet_5.name}")
      end

      it 'each pet has an approve and reject button' do
        visit "/admin/applications/#{@application.id}"
        expect(page).to have_content("Approve #{@pet_5.name}")
        expect(page).to have_content("Reject #{@pet_5.name}")
      end

      it 'admin may click the adoption and it will change the status of the pet to approved and status as not adoptable' do
        visit "/admin/applications/#{@application.id}"
        click_button "Approve #{@pet_3.name}"
        expect(page).to_not have_content("Approve #{@pet_3.name}")
        expect(page).to have_content("Approved")
        expect(page).to have_content("Approve #{@pet_5.name}")
      end

    ## USER STORY 13
      it 'admin may reject a pet from being adopted and neither button is available' do
        visit "/admin/applications/#{@application.id}"
          click_button "Reject #{@pet_5.name}"
          expect(page).to_not have_content("Approve #{@pet_5.name}")
          expect(page).to_not have_content("Reject #{@pet_5.name}")
          expect(page).to have_content("Rejected")
      end

    # USER STORY 14
    it "approved/rejected pets on one application do not affect other applications" do
      
      visit "/admin/applications/#{@application.id}"
      click_button "Approve #{@pet_3.name}"
      click_button "Reject #{@pet_5.name}"
    
      visit "/admin/applications/#{@application_2.id}"

      expect(page).to have_content("Approve #{@pet_3.name}")
      expect(page).to have_content("Reject #{@pet_3.name}")
      expect(page).to have_content("Approve #{@pet_5.name}")
      expect(page).to have_content("Reject #{@pet_5.name}")
    end
  end

  describe '#Managing Completed Applications' do
    ## USER STORY 15
    it "when visiting admin show page and all pets are approved, application status becomes 'Approved'" do
      visit "/admin/applications/#{@application.id}"
      click_button "Approve #{@pet_3.name}"
      click_button "Approve #{@pet_5.name}"
      expect(page).to have_content("Application Status: Approved")
    end

    ## USER STORY 16
    it "when visiting admin show page and one of the pets is rejected, application status becomes 'Rejected'" do
      visit "/admin/applications/#{@application.id}"
      click_button "Approve #{@pet_3.name}"
      click_button "Reject #{@pet_5.name}"
      expect(page).to have_content("Application Status: Rejected")
    end

    ## USER STORY 17
    it "after all pets are approved, going to show page per each pet shows that each pet is no longer 'adoptable'" do
      visit "/admin/applications/#{@application.id}"
      click_button "Approve #{@pet_3.name}"
      click_button "Approve #{@pet_5.name}"
      visit "/pets/#{@pet_3.id}"
      expect(page).to have_content("Status: Not Adoptable")
      visit "/pets/#{@pet_5.id}"
      expect(page).to have_content("Status: Not Adoptable")
    end

    ## USER STORY 18
    it "can only have one approved application per pet at a time" do
      @petapp_5.approve
      visit "/admin/applications/#{@application_3.id}"
      expect(page).to have_content("Application Status: Approved")
      visit "/admin/applications/#{@application_4.id}"
      expect(page).to_not have_content("Approve #{@petapp_5.pet.name}")
      expect(page).to have_content("Pet has been approved on a different application")      # click_button "Approve #{@pet_3.name}"
    end
  end
end

