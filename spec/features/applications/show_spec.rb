require "rails_helper"

RSpec.describe 'application show page', type: :feature do
  before :each do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = @shelter.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom", shelter_id: @shelter.id)
    
    @application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
    @application2 = Application.create!(name: "Britney Spears", street_address: "250 Zimmerman Rd", city: "Hamburg", state: "New York", zip_code: "14075", description: "I am looking for my first dog. I am always home, because I am working from home. Since I am always around, I will be a great responsible dog owner!")
  
    @application1.pets << @pet_1
    @application1.pets << @pet_3
    @application2.pets << @pet_2

  end

  describe 'as a visitor' do
    describe 'when I visit /applications/:id' do
      it 'shows applicant information' do
        #User story 1
      
        visit "/applications/#{@application1.id}"
        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
        expect(page).to have_content(@application1.zip_code)
        expect(page).to have_content(@application1.description)
        expect(page).to have_content(@application1.status)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_link(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
        expect(page).to_not have_link(@pet_2.name)
      end
    end
  end

  describe "adding a pet to an application" do 
    it "has an add pet section and a search bar to find a pet" do 
      #US 4
      visit "/applications/#{@application1.id}"
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("Enter pet name")
      expect(page).to have_button("Search")
    end

    it "searches for pets in the search bar and renders results" do  
      #US 4
      visit "/applications/#{@application1.id}"
      fill_in "Enter pet name", with: "Pom Pom"
      click_button "Search"

      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Pom Pom")
      expect(page).to_not have_content("Lobster")
    end 

    it 'searches for pets with partial name' do
      #US 8
      visit "/applications/#{@application1.id}"
      fill_in "Enter pet name", with: "Pom"
      click_button "Search"

      expect(page).to have_content("Pom Pom")
    end

    it 'renders pets with case insensitive partials' do 
      #US 9 
      visit "/applications/#{@application1.id}"
      fill_in "Enter pet name", with: "pOM"
      click_button "Search"

      expect(page).to have_content("Pom Pom")
    end
    
    it 'adds the pet to under Pets Applied for' do
      #US 5
      application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
      visit "/applications/#{application1.id}"
      fill_in "Enter pet name", with: "Pom Pom"
      click_button "Search"
      click_button "Adopt this Pet"
      expect(current_path).to eq("/applications/#{application1.id}")
      expect(page).to have_content("Pom Pom")
    end
  end

  describe 'submit an application' do
    it 'submits an application with valid data' do
      #US 6
      # PetApplication.create!(pet_id: @pet_1.id, application_id: @application1.id)
      visit "/applications/#{@application1.id}"
      
      expect(page).to have_content("Pom Pom")
      expect(page).to have_button("Submit Application")
      expect(page).to have_content("Description of why I would make a good home")
      
      fill_in "Enter answer", with: "I know how to take care pets!"

      click_button "Submit Application"

      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Pending")
      expect(@application1.status).to eq 1
      expect(page).to have_content("#{@pet_3.name}")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("I know how to take care pets!")
      expect(page).to_not have_content("Add a Pet to this Application")
    end

    it 'cannot submit without pets on an application' do
      application1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")

      visit "/applications/#{application1.id}"

      expect(page).to_not have_button("Submit Application")
      expect(page).to_not have_content("Why I would make a good owner for these pet(s)")
    end
  end
end