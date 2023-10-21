require "rails_helper"

RSpec.describe 'application show page', type: :feature do
  before :each do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = @shelter.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom", shelter_id: @shelter.id)
    
    @applicant1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
    @applicant2 = Application.create!(name: "Britney Spears", street_address: "250 Zimmerman Rd", city: "Hamburg", state: "New York", zip_code: "14075", description: "I am looking for my first dog. I am always home, because I am working from home. Since I am always around, I will be a great responsible dog owner!")
  
    @applicant1.pets << @pet_1
    @applicant1.pets << @pet_3
    @applicant2.pets << @pet_2

  end

  describe 'as a visitor' do
    describe 'when I visit /applications/:id' do
      it 'shows applicant information' do
        #User story 1
      
        visit "/applications/#{@applicant1.id}"
        expect(page).to have_content(@applicant1.name)
        expect(page).to have_content(@applicant1.street_address)
        expect(page).to have_content(@applicant1.city)
        expect(page).to have_content(@applicant1.state)
        expect(page).to have_content(@applicant1.zip_code)
        expect(page).to have_content(@applicant1.description)
        expect(page).to have_content(@applicant1.status)
        expect(page).to have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
      end
    end
  end

  describe "adding a pet to an application" do 
    it "has an add pet section and a search bar to find a pet" do 
      visit "/applications/#{@applicant1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("Enter pet name")
      expect(page).to have_button("Search")
    end

    it "searches for pets in the search bar and renders results" do  
      visit "/applications/#{@applicant1.id}"

      fill_in "Enter pet name", with: "Pom Pom"
      click_button "Search"

      expect(current_path).to eq("/applications/#{@applicant1.id}?pet_name=Pom_Pom&commit=Search")

      expect(page).to have_content("Pom Pom")
      expect(page).to_not have_content("Lobster")
    end 
  end
end