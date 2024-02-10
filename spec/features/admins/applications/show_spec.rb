require "rails_helper"

RSpec.describe "Admins Application Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @turing = Shelter.create!(foster_program: true, name: "Turing", city: "Backend", rank: 3)
    @fsa = Shelter.create!(foster_program: true, name: "Fullstack Academy", city: "Backend", rank: 3)
    @codesmith = Shelter.create!(foster_program: true, name: "Codesmith", city: "Backend", rank: 3)
    @rithm = Shelter.create!(foster_program: true, name: "Rithm School", city: "Backend", rank: 3)
    @hackreactor = Shelter.create!(foster_program: true, name: "Hack Reactor", city: "Backend", rank: 3)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love cats")
    @application_2 = Application.create!(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: 1)
    @application_3 = Application.create!(name: "Jerry", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: 1)

    @application_pet_1 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_3.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_3.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_3.id, pet_id: @pet_4.id)

    visit "/admin/applications/#{@application_2.id}"
  end

  describe "User Story 12 - Approving a Pet for Adoption" do
    it "has a button to approve a Pet application for every pet that the application pet is for" do
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content("Mr. Pirate")
        expect(page).to have_button("Approve Pet Application")
        click_button("Approve Pet Application")

        expect(page.current_path).to eq("/admin/applications/#{@application_2.id}")
        expect(page).to have_content("Pet Approved")
        expect(page.has_button?).to be false
      end
    end
  end

  describe "User Story 13 - Rejecting a Pet for Adoption" do
    it "has a button to reject the application for a pet" do
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_button("Reject Pet Application")
      end
    end

    it "refreshes the page showing the rejected pet" do
      within "#pet-#{@pet_1.id}" do
        click_button("Reject Pet Application")

        expect(page.current_path).to eq("/admin/applications/#{@application_2.id}")
        expect(page.has_button?).to be false
        expect(page).to have_content("Pet Rejected")
      end
    end
  end

  describe "User Story 14 - Approved/Rejected Pets on one Application do not affect other Applications" do
    it "makes sure that approving one pet for an application does not affect another application that also has the same pet" do
      within "#pet-#{@pet_3.id}" do
        expect(page).to have_content("Lucille Bald")
        expect(page).to have_button("Approve")


        click_button("Approve")
        expect(page.current_path).to eq("/admin/applications/#{@application_2.id}")
        expect(page).to have_content("Pet Approved")
      end


    visit "/admin/applications/#{@application_3.id}"
      within "#pet-#{@pet_3.id}" do
        expect(page).to have_content("Lucille Bald")
        expect(page).to have_no_content("Pet Approved")
      end
    end
  end

  describe "User Story 15 - All Pets Accepted on an Application - Completed Applications" do
    it "changes application status to 'approved' when all pets have been approved" do
        within "#pet-#{@pet_3.id}" do
          click_button("Approve")
        end

        within "#pet-#{@pet_1.id}" do
          click_button("Approve")
        end
        expect(page.current_path).to eq("/admin/applications/#{@application_2.id}")
        expect(page).to have_content("Approved")
    end
  end

  describe "User Story 16 - One or More Pets Rejected on an Application" do
    it "rejects an Application when a pet application has been rejected" do
      within "#pet-#{@pet_3.id}" do
        click_button("Approve")
      end
      within "#pet-#{@pet_1.id}" do
        click_button("Reject")
      end

      expect(page.current_path).to eq("/admin/applications/#{@application_2.id}")
      expect(page).to have_content("Application for #{@application_2.name} has been rejected")
    end
  end

  describe "User Story 17 - Application Approval makes Pets not adoptable" do
    it "can change the status of a pet from `adoptable` to `not adoptable` when ALL pets are approved" do
      visit "pets/#{@pet_3.id}"
      expect(page).to have_content("Adoptable: true")

      visit "/admin/applications/#{@application_2.id}"

      within "#pet-#{@pet_3.id}" do
        click_button("Approve")
      end

      visit "pets/#{@pet_3.id}"

      expect(page).to have_no_content("Adoptable: true")

      visit "/admin/applications/#{@application_2.id}"

      within "#pet-#{@pet_1.id}" do
        click_button("Approve")
      end

      visit "pets/#{@pet_1.id}"

      expect(page).to have_no_content("Adoptable: true")
    end
  end

  describe "User Story 18 - Pets can only have one approved application on them at any time" do
    it "will not show a button to approve a pet if it has already been approved on another application" do
      within "#pet-#{@pet_3.id}" do
        expect(page).to have_button("Approve")
        click_button("Approve")
        expect(page).to have_content("Pet Approved")
      end
      within "#pet-#{@pet_1.id}" do
        expect(page).to have_button("Approve")
      end
      visit "/pets/#{@pet_3.id}"
      expect(page).to have_content("Adoptable: false")

      visit "/admin/applications/#{@application_3.id}"
      within "#pet-#{@pet_3.id}" do
        expect(page).to have_no_button("Approve")
        expect(page).to have_content("This pet has already been approved for adoption")
        expect(page).to have_button("Reject")
      end
    end
  end

end
