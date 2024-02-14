require "rails_helper"

RSpec.describe "Admin application show page" do

  describe 'US 12 ' do
    describe 'Approving a pet for Adoption' do
      it 'has buttons to approve a pets for that application' do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        shaggy = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ",status: "Pending")
        
        pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
        pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true )
        pet_3 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

        shaggy.pets << [pet_1,pet_2,pet_3]

        # When I visit an admin application show page ('/admin/applications/:id')
        visit "/admin/applications/#{shaggy.id}"
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        within "#Pet-#{pet_1.id}" do
            expect(page).to have_button("Approve #{pet_1.name}")
        end
        within "#Pet-#{pet_2.id}" do
          expect(page).to have_button("Approve #{pet_2.name}")
        end

        within "#Pet-#{pet_3.id}" do
          expect(page).to have_button("Approve #{pet_3.name}")
          click_button("Approve #{pet_3.name}")
        end
        # When I click that button
        

        # Then I'm taken back to the admin application show page
        expect(current_path).to eq("/admin/applications/#{shaggy.id}")

        # And next to the pet that I approved, I do not see a button to approve this pet

        within "#Pet-#{pet_3.id}" do
          expect(page).to_not have_button("Approve #{pet_3.name}")
          expect(page).to_not have_button("Reject #{pet_3.name}")
          # And instead I see an indicator next to the pet that they have been approved
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

  describe 'US 14' do
    it 'does not affect pending apps when pet is approved/rejected' do

      aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      rgv_shelter = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

      pet_1 = aurora_shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
      pet_2 = rgv_shelter.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true )
      pet_3 = aurora_shelter.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

      martin = Application.create!(name: "Martin", street_address: "134 Huski Lane", city: "Chicago", state: "Ilinois", zip_code: 60609, description: "I love dogs", status: "Pending")
      odell = Application.create!(name: "Odell", street_address: "145 Dog Lane", city: "Denver", state: "CO", zip_code: 60655, description: "Hi!", id: 1)

      odell.pets << [pet_1, pet_2]
      martin.pets << [pet_3, pet_2]
      
      # 14. Approved/Rejected Pets on one Application do not affect other Applications

      # As a visitor
      # When there are two applications in the system for the same pet
      # When I visit the admin application show page for one of the applications
      visit "/admin/applications/#{odell.id}"
      # And I approve or reject the pet for that application
      click_button("Approve Clawdia")
      # When I visit the other application's admin show page
      visit "/admin/applications/#{martin.id}"
      # Then I do not see that the pet has been accepted or rejected for that application
      within "#Pet-#{pet_2.id}" do 
        expect(page).to_not have_content('Rejected')
        expect(page).to_not have_content('Accepted')
       end
      # And instead I see buttons to approve or reject the pet for this specific application
      within "#Pet-#{pet_2.id}" do 
        expect(page).to have_button("Approve Clawdia")
        expect(page).to have_button("Reject Clawdia")
       end
      
    end
  end
  
end