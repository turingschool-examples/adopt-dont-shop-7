require 'rails_helper' 

RSpec.describe "Application Show Page" do 
  # let(:shelter) { Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) } 
  # let(:application1) { Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I lika da pets", status: "In Progress") } 
  # let(:pet1) { Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id) } 
  # let(:pet2) { Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id) }
  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
  end
  describe "visiting the application show page" do 
    it 'shows the applicant and all the applicants details' do 
      
      visit "/applications/#{@application1.id}"

      expect(page).to have_content("Name: #{@application1.name}")
      expect(page).to have_content("Street Address: #{@application1.street_address}")
      expect(page).to have_content("#{@application1.city}")
      expect(page).to have_content("#{@application1.state}")
      expect(page).to have_content("#{@application1.zip_code}")
      expect(page).to have_content("Why I would make a good home: #{@application1.description}")
      expect(page).to have_content("Applying to Adopt:" )
      expect(page).to have_content("Status: #{@application1.status}")
    end
    
    it "shows a search for pets and lists matches to that pet name" do
      visit "/applications/#{@application1.id}"

      within("#pet_search") do
        expect(page).to have_field(:search)
        expect(page).to have_button("Search")
        fill_in(:search, with: "Mr. Pirate")
        click_button("Search")
      end

      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Mr. Pirate")
    end
    describe "When I visit an application's show page and I search for a Pet by name" do 
      it "has a button to adopt a pet, next to each pets name that will add that pet to the application" do 
        visit "/applications/#{@application1.id}"
        
        within("#pet_search") do
        fill_in(:search, with: "Mr. Pirate")
        click_button("Search")
      end
      expect(page).to have_button("Adopt this Pet")

      click_button("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Applying to Adopt: #{@pet_1.name}")

      end
    end
    context "Submit an Application" do

      # And I have added one or more pets to the application
      # Then I see a section to submit my application
      # And in that section I see an input to enter why I would make a good owner for these pet(s)
      # When I fill in that input
      # And I click a button to submit this application
      # Then I am taken back to the application's show page
      # And I see an indicator that the application is "Pending"
      # And I see all the pets that I want to adopt
      # And I do not see a section to add more pets to this application
    end
  end
end 
