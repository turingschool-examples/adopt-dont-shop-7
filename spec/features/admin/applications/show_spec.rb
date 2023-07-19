require "rails_helper"

RSpec.describe "Admin applications Show" do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter', city: 'Denver', foster_program: false, rank: 2)
    @shelter_2 = Shelter.create!(name: 'Boulder Animal Shelter', city: 'Boulder', foster_program: false, rank: 3)
    @shelter_3 = Shelter.create!(name: 'Dallas Animal Shelter', city: 'Dallas', foster_program: false, rank: 2)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'Golden Retriever', name: 'Buddy')
    @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'American Bulldog', name: 'Rover')
    @pet_3 = @shelter_3.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Max')
    @pet_4 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'Spud')
    @pet_5 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'SpuddyBuddy')

    @application_1 = Application.create!(name: 'John Smith', street_address: '1234 Fake Street', city: 'Denver', state: 'CO', zip_code: 80202, description: 'Big Yak guy, but a dog will do', status: 'In Progress')
    @application_2 = Application.create!(name: 'Jane Doe', street_address: '5678 Wannabe Road', city: 'Boulder', state: 'CO', zip_code: 80301, description: 'I love cats!', status: 'In Progress')
    @application_3 = Application.create!(name: 'Joe Schmoe', street_address: '90210 Round Drive', city: 'Dallas', state: 'TX', zip_code: 75214, description: 'I like Turtles!', status: 'In Progress')
  end

  describe "approving a pet for adoption" do
    it "displays all pets on that application" do
      @application_1.pets << @pet_1
      @application_1.pets << @pet_4

      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_4.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_3.name)
    end

    it 'has a button to approve the pet for adoption' do
      @application_1.pets << @pet_1

      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
      expect(page).to_not have_button("Approve #{@pet_2.name} for Adoption")

      click_on "Approve #{@pet_1.name} for Adoption"

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")

      expect(page).to have_content("#{@pet_1.name} is approved for adoption!")
      expect(page).to_not have_button("Approve #{@pet_1.name} for Adoption")
    end
    
    it 'has a button to reject the pet for adoption' do
      @application_2.pets << @pet_2
      @application_2.pets << @pet_3

      visit "/admin/applications/#{@application_2.id}"

      expect(page).to have_button("Reject #{@pet_2.name} for Adoption")
      expect(page).to_not have_button("Reject #{@pet_1.name} for Adoption")
      
      click_on "Reject #{@pet_2.name} for Adoption"
      
      expect(current_path).to eq("/admin/applications/#{@application_2.id}")

      expect(page).to_not have_button("Reject #{@pet_2.name} for Adoption")

      expect(page).to have_content("#{@pet_2.name} is rejected for adoption.")
    end

    it "Two applications apply for the same pet. As admin, I go to the 
        first applications's show page, APPROVE their application. When I
        visit the second applications's show page, I still see the buttons
        to either accept or reject their specific application for that pet." do
      @application_1.pets << @pet_1

      visit "/admin/applications/#{@application_1.id}"

      click_on "Approve #{@pet_1.name} for Adoption"

      @application_2.pets << @pet_1

      visit "/admin/applications/#{@application_2.id}"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")
      end
    end

    it "Two applications apply for the same pet. As admin, I go to the 
        first application's show page, REJECT their application. When I
        visit the second application's show page, I still see the buttons
        to either accept or reject their specific application for that pet." do
      @application_1.pets << @pet_1

      visit "/admin/applications/#{@application_1.id}"

      click_on "Reject #{@pet_1.name} for Adoption"

      @application_2.pets << @pet_1

      visit "/admin/applications/#{@application_2.id}"

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button("Approve #{@pet_1.name} for Adoption")
        expect(page).to have_button("Reject #{@pet_1.name} for Adoption")
      end
    end
  end
end
