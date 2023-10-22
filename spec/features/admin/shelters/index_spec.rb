require 'rails_helper'

RSpec.describe 'admin/shelters' do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald") 
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster") 
    @pet_3 = @shelter_1.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom") 

    @application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!",status: "Pending")
    @application2 = Application.create!(name: "Britney Spears", street_address: "250 Zimmerman Rd", city: "Hamburg", state: "New York", zip_code: "14075", description: "I am looking for my first dog. I am always home, because I am working from home. Since I am always around, I will be a great responsible dog owner!",status: "Pending")

    @application1.pets << @pet_1
    @application1.pets << @pet_3
    @application2.pets << @pet_2
  end

  
  describe 'as a visitor' do
    describe 'when I visit admin/shelters' do
      it 'shows shelters in reverse alphabetical order' do
        # US 10
        visit '/admin/shelters'
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end

      it 'shows shelters with pending applications' do 
        # US 11 
        visit '/admin/shelters'
        expect(page).to have_content("Shelters with Pending Applications")

        within "#pending_shelter-#{@shelter_1.id}" do 
          expect(page).to have_content(@shelter_1.name)
          expect(page).to_not have_content(@shelter_2.name)
          expect(page).to_not have_content(@shelter_3.name)
          save_and_open_page
        end 
      end
    end
  end

end