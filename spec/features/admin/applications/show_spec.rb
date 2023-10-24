require 'rails_helper'

RSpec.describe '/admin/applications/:id' do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster") 
    @pet_3 = @shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 

    @application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
    @application2 = Application.create!(name: "Britney Spears", street_address: "250 Zimmerman Rd", city: "Hamburg", state: "New York", zip_code: "14075", description: "I am looking for my first dog. I am always home, because I am working from home. Since I am always around, I will be a great responsible dog owner!", status: "Pending")

    @application1.pets << @pet_1
    @application1.pets << @pet_3
    @application2.pets << @pet_2
  end
  
  describe 'as a visitor' do
    describe 'when I visit /admin/applications/:id' do
      it 'has displays button to approve for adoption' do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
        pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
        pet_3 = shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 
        application1.pets << pet_1
        application1.pets << pet_3

        visit "/applications/#{@application1.id}"
        fill_in :description, with: "I know how to take care pets!"
        click_button "Submit Application"

        visit "/admin/applications/#{@application1.id}"
        expect(page).to have_button("Approve", count: 2)
      end

      it 'approves a pet for adoption' do
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

        within("#pet-#{pet_1.id}") do
          click_button "Approve"
          expect(current_path).to eq("/admin/applications/#{application1.id}")
          expect(page).to_not have_button("Approve")
          expect(page).to have_content("Approved")
        end
        
      end
    end
  end
end