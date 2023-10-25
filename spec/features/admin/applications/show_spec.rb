require "rails_helper"

RSpec.describe "Admin Application Show Page", type: :feature do

  describe "As a visitor" do
    describe "When I visit '/admin/applications/:id'" do
      before(:each) do
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "doberman", name: "Auggie", shelter_id: @shelter_1.id)
        @pet_2 = Pet.create!(adoptable: true, age: 6, breed: "pug", name: "Rue", shelter_id: @shelter_1.id)
        @pet_3 = Pet.create(adoptable: true, age: 3, breed: "boxer", name: "Ann", shelter_id: @shelter_1.id)
        @application_1 = Application.create!(name: "Julie Johnson", street_address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", status: "In Progress")
        @application_2 = Application.create!(name: "Steve Smith", street_address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", status: "In Progress")
        @applicant_1 = PetApplication.create(application_id: @application_1.id, pet_id: @pet_1.id)
        @applicant_2 = PetApplication.create(application_id: @application_1.id, pet_id: @pet_3.id)
        @applicant_3 = PetApplication.create(application_id: @application_2.id, pet_id: @pet_2.id)
      end 

      it "For every pet that the application is for, I see a button to approve the application for that specific pet" do

        visit "admin/applications/#{@application_1.id}"

        within("#Auggie") do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_button("Approve")
        end 

        within("#Ann") do
          expect(page).to have_content(@pet_3.name)
          expect(page).to have_button("Approve")
        end
      end

      it "when I click that button, then I am taken back to the application show page" do

        visit "admin/applications/#{@application_1.id}"

        within("#Auggie") do
          click_button("Approve")
          expect(page).to have_content("Approved")
          expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
        end

        within("#Ann") do
          expect(page).to_not have_content("Approved")
        end
      end

      it "For every pet that the application is for, I see a button to reject the application for that specific pet" do

        visit "admin/applications/#{@application_1.id}"

        within("#Auggie") do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end 

        within("#Ann") do
          expect(page).to have_content(@pet_3.name)
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end
      end

      it "when I click that button (reject), then I am taken back to the application show page" do

        visit "admin/applications/#{@application_1.id}"

        within("#Auggie") do
          click_button("Reject")
          expect(page).to have_content("Rejected")
          expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
        end

        within("#Ann") do
          expect(page).to_not have_content("Rejected")
        end
      end

      it "When I click approve or reject buttons, they update the pets status and disappear from the view page" do

        visit "admin/applications/#{@application_1.id}"

        within("#Auggie") do
          click_button("Reject")
          expect(page).to have_content("Rejected")
        end

        within("#Ann") do
          click_button("Approve")
          expect(page).to have_content("Approved")
        end

        expect(page).to_not have_css(".button-group")
      end
    end
  end
end
