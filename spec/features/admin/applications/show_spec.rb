require 'rails_helper'

RSpec.describe '/admin/applications/:id' do
  describe 'as a visitor' do
    describe 'when I visit /admin/applications/:id' do
      it 'has displays button to approve and reject for adoption' do
        #US 12 & 13
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
        pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 
        application1.pets << pet_1
        application1.pets << pet_3

        visit "/applications/#{application1.id}"
        fill_in :description, with: "I know how to take care pets!"
        click_button "Submit Application"

        visit "/admin/applications/#{application1.id}"
        expect(page).to have_button("Approve", count: 2)
        expect(page).to have_button("Reject", count: 2)
      end

      it 'approves a pet for adoption' do
        #US 12
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
        pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 

        application1.pets << pet_1
        application1.pets << pet_3

        visit "/applications/#{application1.id}"
        fill_in :description, with: "I know how to take care pets!"
        click_button "Submit Application"

        visit "/admin/applications/#{application1.id}"

        within("tr:contains('#{pet_1.name}')") do
          click_button 'Approve'
        end

        within("tr:contains('#{pet_1.name}')") do
          expect(page).not_to have_button('Approve')
          expect(page).to have_content('Approved')
        end

        within("tr:contains('#{pet_3.name}')") do
          expect(page).to have_button 'Approve'
        end
      end

      it 'rejects a pet for adoption' do
        #US 13
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
        pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 

        application1.pets << pet_1
        application1.pets << pet_3

        visit "/applications/#{application1.id}"
        fill_in :description, with: "I know how to take care pets!"
        click_button "Submit Application"

        visit "/admin/applications/#{application1.id}"

        within("tr:contains('#{pet_1.name}')") do
          click_button 'Reject'
        end

        within("tr:contains('#{pet_1.name}')") do
          expect(page).not_to have_button('Reject')
          expect(page).to have_content('Rejected')
        end

        within("tr:contains('#{pet_3.name}')") do
          expect(page).to have_button 'Reject'
          expect(page).to have_button 'Approve'
        end
      end

      it 'approved/rejected pets on one application does not affect other applications' do
        #US 14
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
        application2 = Application.create!(name: "Carrie Bradshaw", street_address: "605 Main St.", city: "Manhattan", state: "New York", zip_code: "01540", description: "I need a pet to replace my shoes")

        pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 

        application1.pets << pet_1
        application1.pets << pet_3
        application2.pets << pet_3

        visit "/applications/#{application1.id}"
        fill_in :description, with: "I know how to take care pets!"
        click_button "Submit Application"

        visit "/admin/applications/#{application1.id}"

        within("tr:contains('#{pet_3.name}')") do
          click_button 'Approve'
        end

        visit "/applications/#{application2.id}"
        fill_in :description, with: "I will love them!"
        click_button "Submit Application"

        visit "/admin/applications/#{application2.id}"
        
        within("tr:contains('#{pet_3.name}')") do
          expect(page).to have_button 'Reject'
          expect(page).to have_button 'Approve'
        end
      end
    end
  end
end