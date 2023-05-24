require "rails_helper"

RSpec.describe "Admin Shelters Show Page", type: :feature do
  describe "admin_shelters#show" do
    before(:each) do
      @shelter1 = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
      @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "Samoyed", name: "Fluffy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age: 6, breed: "Husky", name: "Hubert")
      # ^ not applied by anyone
      @pet3 = @shelter1.pets.create!(adoptable: true, age: 8, breed: "Shiba Inu", name: "Shishi")

      @shelter2 = Shelter.create!(foster_program: true, name: "Chicago Animal Rescue", city: "Chicago", rank: 4)
      @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Lally")
      @pet5 = @shelter2.pets.create!(adoptable: true, age: 10, breed: "Chihuahua", name: "Chewy")

      @shelter3 = Shelter.create!(foster_program: true, name: "Los Angeles Animal Rescue", city: "Los Angeles", rank: 3)
      @pet6 = @shelter3.pets.create!(adoptable: true, age: 5, breed: "Pitbull", name: "Bully")

      @app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled", status: "In Progress")
      @petapp1 = PetApplication.create!(application_id: @app1.id, pet_id: @pet1.id)
      @petapp2 = PetApplication.create!(application_id: @app1.id, pet_id: @pet4.id)

      @app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled", status: "Pending")
      @petapp3 = PetApplication.create!(application_id: @app2.id, pet_id: @pet1.id)
      @petapp4 = PetApplication.create!(application_id: @app2.id, pet_id: @pet3.id)
      @petapp5 = PetApplication.create!(application_id: @app2.id, pet_id: @pet6.id)

      @app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled", status: "Rejected")
      @petapp6 = PetApplication.create!(application_id: @app3.id, pet_id: @pet5.id, pet_applications_status: "Pending")
    end

    it "can approve pet applications" do
      # 12. Approving a Pet for Adoption

      # As a visitor
      # When I visit an admin application show page ('/admin/applications/:id')
      # For every pet that the application is for, I see a button to approve the application for that specific pet
      # When I click that button
      # Then I'm taken back to the admin application show page
      # And next to the pet that I approved, I do not see a button to approve this pet
      # And instead I see an indicator next to the pet that they have been approved

      visit "/admin/applications/#{@app3.id}"

      within "#pet_application-#{@pet5.id}" do
        expect(page).to have_content(@pet5.name)
        expect(page).to have_content("Status: Pending")
        expect(page).to have_button("Approve Pet Application")
      end

      expect(@petapp6.pet_applications_status).to eq("Pending")

      click_button("Approve Pet Application")
      expect(current_path).to eq("/admin/applications/#{@app3.id}")

      @pet5.reload
      
      within "#pet_application-#{@pet5.id}" do
        expect(page).to have_content(@pet5.name)
        expect(page).to have_content("Status: Approved")
        expect(page).to_not have_button("Approve Pet Application")
      end

      expect(@petapp6.reload.pet_applications_status).to eq("Approved")
    end

    it "can deny pet applications" do
      # 13. Rejecting a Pet for Adoption

      # As a visitor
      # When I visit an admin application show page ('/admin/applications/:id')
      # For every pet that the application is for, I see a button to reject the application for that specific pet
      # When I click that button
      # Then I'm taken back to the admin application show page
      # And next to the pet that I rejected, I do not see a button to approve or reject this pet
      # And instead I see an indicator next to the pet that they have been rejected

      visit "/admin/applications/#{@app3.id}"

      within "#pet_application-#{@pet5.id}" do
        expect(page).to have_content(@pet5.name)
        expect(page).to have_content("Status: Pending")
        expect(page).to have_button("Approve Pet Application")
        expect(page).to have_button("Reject Pet Application")
      end

      expect(@petapp6.pet_applications_status).to eq("Pending")

      click_button("Reject Pet Application")
      expect(current_path).to eq("/admin/applications/#{@app3.id}")

      within "#pet_application-#{@pet5.id}" do
        expect(page).to have_content(@pet5.name)
        expect(page).to have_content("Status: Rejected")
        expect(page).to_not have_button("Approve Pet Application")
        expect(page).to_not have_button("Reject Pet Application")
      end

      expect(@petapp6.reload.pet_applications_status).to eq("Rejected")
    end
  end
end
