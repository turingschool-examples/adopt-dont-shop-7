require "rails_helper"

RSpec.describe "Admin application show page" do

  describe 'US 12 ' do
    describe 'Approving a pet for Adoption' do
      it 'has buttons to approve a pets for that application' do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shaggy = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ",status: "Pending")
        
        @pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
        @pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true )
        @pet_3 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

        shaggy.pets << [@pet_1,@pet_2,@pet_3]

        # When I visit an admin application show page ('/admin/applications/:id')
        visit "/admin/applications/#{shaggy.id}"
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        shaggy.pets.each do |pet|
          expect(page).to have_button("Approve #{pet.name}")
        end

        # When I click that button
        click_button("Approve #{@pet_1.name}")

        # Then I'm taken back to the admin application show page
        expect(current_path).to eq("/admin/applications/#{shaggy.id}")

        # And next to the pet that I approved, I do not see a button to approve this pet
        expect(page).to_not have_button("Approve #{@pet_1.name}")

        # And instead I see an indicator next to the pet that they have been approved
       within "#Pet-#{@pet_1.id}" do 
        expect(page).to have_content('Approved')
       end
      end
    end
  end

  describe 'US 13 ' do
    describe 'Rejecting a pet for Adoption' do
      it 'has buttons to Reject a pet for that application' do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shaggy = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ",status: "Pending")
        
        @pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
        @pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true )
        @pet_3 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

        shaggy.pets << [@pet_1,@pet_2,@pet_3]

        # When I visit an admin application show page ('/admin/applications/:id')
        visit "/admin/applications/#{shaggy.id}"
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        shaggy.pets.each do |pet|
          expect(page).to have_button("Reject #{pet.name}")
        end

        # When I click that button
        click_button("Reject #{@pet_1.name}")

        # Then I'm taken back to the admin application show page
        expect(current_path).to eq("/admin/applications/#{shaggy.id}")

        # And next to the pet that I approved, I do not see a button to approve this pet
        expect(page).to_not have_button("Rejected #{@pet_1.name}")

        # And instead I see an indicator next to the pet that they have been approved
       within "#Pet-#{@pet_1.id}" do 
        expect(page).to have_content('Rejected')
       end
      end
    end
  end
  
end