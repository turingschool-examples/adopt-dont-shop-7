require 'rails_helper'

RSpec.describe 'the admin apps index', type: :feature do
  describe 'As a visitor' do # As a visitor
    before(:each) do
      # Shelters
      @puppy_hope = Shelter.create!(name: 'Puppy Hope', city: 'Palo Alto',foster_program: true, rank: 1 )
      @the_farm = Shelter.create!(name: 'South Shannon Angus', city: 'Palo Alto',foster_program: true, rank: 1 )
      @walrus_haven = Shelter.create!(name: "Cicero's Walrus Emporium", city: 'Palo Alto',foster_program: true, rank: 1 )
      # Pets
      @pet_1 = Pet.create!(name: 'Sparky', age: 4, breed: 'Chihuahua', adoptable: true, shelter_id: @puppy_hope.id )
      @pet_2 = Pet.create!(name: 'Spot', age: 1, breed: 'Angus', adoptable: true, shelter_id: @puppy_hope.id )
      @pet_3 = Pet.create!(name: 'Spotty', age: 10, breed: 'Walrus', adoptable: true, shelter_id: @puppy_hope.id )
      @pet_4 = Pet.create!(name: 'Spotty', age: 11, breed: 'Walrus', adoptable: true, shelter_id: @walrus_haven.id )
      # Applications 
      @app_1 = Application.create!(name: 'Megan Samuels', street_address: '505 E. Happy Pl', city: "Austin", state: "MN", zip: "55912", description: 'I love dogs', status: 0)
      @app_2 = Application.create!(name: 'Wyatt Earp', street_address: 'taocs st', city: "Dallas", state: "FL", zip: "67811", description: 'I have a particular set of skills', status: 1)
      @app_3 = Application.create!(name: 'Dean Winchester', street_address: 'Bronco Dr', city: "New York", state: "IA", zip: "76543", description: 'I hug cactus', status: 1)
      # Pet Applications 
      PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
      PetApp.create!(application_id: @app_1.id, pet_id: @pet_4.id)
      PetApp.create!(application_id: @app_2.id, pet_id: @pet_4.id)
      PetApp.create!(application_id: @app_3.id, pet_id: @pet_3.id)
    end

    # 12. Approving a Pet for Adoption
    it "12. Approving a Pet for Adoption" do 
        # When I visit an admin application show page ('/admin/applications/:id')
        visit "/admin/applications/#{@app_3.id}"
        within '.pet_apps' do
          # For every pet that the application is for, I see a button to approve the application for that specific pet
          expect(page).to have_button("Approve Application")
          # When I click that button
          click_button("Approve Application")
        end
        @app_3 = Application.find(@app_3.id)
        # Then I'm taken back to the admin application show page
        expect(current_path).to eq("/admin/applications/#{@app_3.id}")
        within '.pet_apps' do
          # And next to the pet that I approved, I do not see a button to approve this pet
          expect(page).to_not have_button("Approve Application")
          # And instead I see an indicator next to the pet that they have been approved
          expect(page).to have_content("Application Approved")
        end
    end

    # 13. Rejecting a Pet for Adoption
    it "13. Rejecting a Pet for Adoption" do
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{@app_3.id}"
      within '.pet_apps' do
        # For every pet that the application is for, I see a button to reject the application for that specific pet
        expect(page).to have_button("Reject Application")
        # When I click that button
        click_button("Reject Application")
      end
      @app_3 = Application.find(@app_3.id)
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/applications/#{@app_3.id}")
      within '.pet_apps' do
        # And next to the pet that I rejected, I do not see a button to approve or reject this pet
        expect(page).to_not have_button("Approve Application")
        expect(page).to_not have_button("Reject Application")
        # And instead I see an indicator next to the pet that they have been rejected
        expect(page).to have_content("Application Rejected")
      end
    end

    # 14. Approved/Rejected Pets on one Application do not affect other Applications
    it "14. Approved/Rejected Pets on one Application do not affect other Applications" do
      # When there are two applications in the system for the same pet
      # app_1 and app_2
      # When I visit the admin application show page for one of the applications
      visit "/admin/applications/#{@app_2.id}"
      within '.pet_apps' do
        # And I approve or reject the pet for that application
        click_button("Reject Application")
      end
      # When I visit the other application's admin show page
      visit "/admin/applications/#{@app_1.id}"
      within '.pet_apps' do
        # Then I do not see that the pet has been accepted or rejected for that application
        expect(page).to_not have_content("Application Rejected")
        expect(page).to_not have_content("Application Approved")
        # And instead I see buttons to approve or reject the pet for this specific application
        expect(page).to have_button("Reject Application")
        expect(page).to have_button("Approve Application")
      end
    end
  end 
end


