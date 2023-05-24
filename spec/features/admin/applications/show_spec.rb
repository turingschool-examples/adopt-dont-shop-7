require "rails_helper"

RSpec.describe "/admin/applications/:id" do 
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

    @susie = Application.create!(
      name: "Susie", 
      street_address: "5234 S Jamaica", 
      city: "Fargo", 
      state: "MI", 
      zip: "45896", 
      description: "Loves alligators.", 
      reason: "Trying a mammal on for size.",
      status: "Pending"
    )

    @tom = Application.create!(
      name: "Thomas", 
      street_address: "5234 S Jefferson", 
      city: "Julian", 
      state: "AL", 
      zip: "43896", 
      description: "Has owned a pet.", 
      reason: "Aspiring to own two.",
      status: "Pending"
    )
    
    ApplicationPet.create!(pet: @pet_1, application: @susie)
    ApplicationPet.create!(pet: @pet_2, application: @susie)
    
    ApplicationPet.create!(pet: @pet_1, application: @tom)
    ApplicationPet.create!(pet: @pet_2, application: @tom)
    ApplicationPet.create!(pet: @pet_3, application: @tom)
  end

  #User Story 12
  describe "Approving a Pet for Adoption" do 
    it "displays admin applications show page" do 
      visit "/admin/applications/#{@susie.id}"
      within("#applicant-info") do 
        expect(page).to have_content(@susie.name)
        expect(page).to have_content("Street Address: #{@susie.street_address}")
        expect(page).to have_content("City: #{@susie.city}")
        expect(page).to have_content("State: #{@susie.state}")
        expect(page).to have_content("Zip Code: #{@susie.zip}")
        expect(page).to have_content("Applicant Description: #{@susie.description}")
        expect(page).to have_content("Reason for Adoption: #{@susie.reason}")
        expect(page).to have_content("Status of All Pet Applications: #{@susie.status}")
      end
      
      within("#pets-on-application") do 
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_content(@pet_3.name)
      end
    end

    it "displays a button to approve application for each specific pet" do 
      visit "/admin/applications/#{@susie.id}"
      within("#pets-on-application") do 
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_2.name} for Adoption")
        expect(page).to_not have_button("Approve #{@pet_3.name} for Adoption")
      end
    end

    it "when approved, redirects to show page, and removes approve button/adds indicator for specific pet" do 
      visit "/admin/applications/#{@susie.id}"
      within("#pets-on-application") do 
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")

        click_button("Approve #{@pet_1.name} for Adoption")

        expect(current_path).to eq("/admin/applications/#{@susie.id}")
        expect(page).to_not have_button ("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_content("#{@pet_1.name}: Approved for Adoption")
      end
    end
  end

  #User Story 13
  describe "Rejecting a Pet for Adoption" do 
    it "displays a button to reject application for each specific pet" do 
      visit "/admin/applications/#{@susie.id}"
      within("#pets-on-application") do 
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_2.name} for Adoption")
        expect(page).to_not have_button("Reject #{@pet_3.name} for Adoption")
      end
    end

    it "when approved, redirects to show page, and removes approve button/adds indicator for specific pet" do 
      visit "/admin/applications/#{@susie.id}"
      within("#pets-on-application") do 
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")

        click_button("Reject #{@pet_1.name} for Adoption")
        
        expect(current_path).to eq("/admin/applications/#{@susie.id}")
        expect(page).to_not have_button ("Reject #{@pet_1.name} for Adoption")
        expect(page).to have_content("#{@pet_1.name}: Rejected for Adoption")
      end
    end
  end

  # User Story 14
  describe "Approved/Rejected Pets on one Application do not affect other Applications" do 
    it "pet approval or rejection for one applicant does not affect the admin/application show page for another applicant" do 
      visit "/admin/applications/#{@susie.id}"
      
      within("#pets-on-application") do 
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_2.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_2.name} for Adoption")
        
        click_button("Approve #{@pet_1.name} for Adoption")
        
        expect(page).to_not have_button ("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_content("#{@pet_1.name}: Approved for Adoption")

        click_button("Reject #{@pet_2.name} for Adoption")

        expect(page).to_not have_button ("Reject #{@pet_2.name} for Adoption")
        expect(page).to have_content("#{@pet_2.name}: Rejected for Adoption")
      end

      visit "/admin/applications/#{@tom.id}"

      within("#pets-on-application") do 
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_2.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_2.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_3.name} for Adoption")
        expect(page).to have_button("Approve #{@pet_3.name} for Adoption")
      end
    end
  end
end