require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
  end

  context "User Story 12: Approving a Pet for Adoption" do
    describe "As a visitor, when I visit an admin application page" do
      it "For every pet on the application, I see a button to approve the application for that pet" do
        visit "/applications/#{@application_1.id}"
        fill_in "Search", with: "Ba"
        click_on("Search")
        
        within "#pet-#{@pet_1.id}" do
          click_button("Adopt this Pet")
        end

        within "#appliedPets" do
          fill_in("add_qualifications", with: "I also have a dog named Lola who is a showgirl.")
          click_button("Submit")
        end

        @application_1.pets << @pet_2
        visit "/admin/applications/#{@application_1.id}"

        within "#pet-#{@pet_2.id}" do
          expect(page).to have_button("Approve")
        end

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Approve")
          click_button("Approve")
        end

        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_content("#{@pet_1.name} : #{@application_1.application_pets.first.status}")       
          expect(page).to_not have_selector(:link_or_button, "Approve")
        end
      end
    end
  end

  context "User Story 13: Rejecting a Pet for Adoption" do
    describe "As a visitor, when I visit an admin application page" do
      it "For every pet on the application, I see a button to reject the application for that pet" do
        visit "/applications/#{@application_1.id}"
        fill_in "Search", with: "Ba"
        click_on("Search")
        
        within "#pet-#{@pet_1.id}" do
          click_button("Adopt this Pet")
        end

        within "#appliedPets" do
          fill_in("add_qualifications", with: "I also have a dog named Lola who is a showgirl.")
          click_button("Submit")
        end

        @application_1.pets << @pet_2
        visit "/admin/applications/#{@application_1.id}"

        within "#pet-#{@pet_2.id}" do
          expect(page).to have_button("Reject")
        end

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Reject")
          click_button("Reject")
        end

        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_content("#{@pet_1.name} : #{@application_1.application_pets.first.status}")       
          expect(page).to_not have_selector(:link_or_button, "Reject")
        end
      end
    end
  end

  context "User Story 14: Accepting/Rejecting is specific to an application" do
    describe "As a visitor, when I visit an admin application page" do
      it "For every pet on the application, I see a button to reject the application for that pet" do
        visit "/applications/#{@application_1.id}"
        fill_in "Search", with: "Ba"
        click_on("Search")
        
        within "#pet-#{@pet_1.id}" do
          click_button("Adopt this Pet")
        end

        within "#appliedPets" do
          fill_in("add_qualifications", with: "I also have a dog named Lola who is a showgirl.")
          click_button("Submit")
        end

        @application_1.pets << @pet_2
        visit "/admin/applications/#{@application_1.id}"

        within "#pet-#{@pet_2.id}" do
          expect(page).to have_button("Reject")
        end

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Reject")
          click_button("Reject")
        end

        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_content("#{@pet_1.name} : #{@application_1.application_pets.first.status}")       
          expect(page).to_not have_selector(:link_or_button, "Reject")
        end
      end
    end
  end



end


# 12. Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

