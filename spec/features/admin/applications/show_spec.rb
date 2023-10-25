require 'rails_helper'

RSpec.describe "Admin Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
    @application_2 = Application.create!(name: "Charlie Moon", street_address: "340 Walker St", city: "San Diego", state: "CA", zip_code: 91911, description: "I really am hoping to find a new companion for my parrot", status: "In Progress")

    @petapp_1 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_3.id)
    @petapp_2 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_5.id)
    @petapp_3 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_3.id)
    @petapp_4 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_5.id)
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
        # within(@pet_5.name) do
          click_button "Reject #{@pet_5.name}"
          expect(page).to_not have_content("Approve #{@pet_5.name}")
          expect(page).to_not have_content("Reject #{@pet_5.name}")
          expect(page).to have_content("Rejected")
        # end
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

      # within(@pet_1) do
      #   click_button("Reject")
      #   expect(page).to have_content("Rejected")
      # end
      
      # within(@pet_2) do
      #   click_button("Approve")
      #   expect(page).to have_content("Approved")
      # end

      # visit "/admin/applications/#{@application_2.id}"

      # within(@pet_1) do
      #   expect(page).to have_content(@pet_1.name)
      #   expect(page).to have_button("Approve")
      #   expect(page).to have_button("Reject")
      # end

      # within(@pet_2) do
      #   expect(page).to have_content(@pet_2.name)
      #   expect(page).to have_button("Approve")
      #   expect(page).to have_button("Reject")
      # end
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
  end
end

