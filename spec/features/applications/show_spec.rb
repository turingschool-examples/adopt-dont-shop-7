require "rails_helper"

RSpec.describe "applications#show" do
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Snoopy", breed: "beagle", age: 11, adoptable: false)
    @application_1 = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"In Progress" )
  end

  describe "display applicant info" do
    it "has applicant info listed in top section of the page" do 
      visit "/applications/#{@application_1.id}"

      within("#applicant_info-#{@application_1.id}") do 
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.street_address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zipcode)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.status)
      end 
    end
  end

  describe "Search for pets" do 
    it "returns pet's name when searched for in the seach bar" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "Mr. Pirate")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@application_1.id}")

      within("#pet_search_results-#{@pet_1.id}") do
        expect(page).to have_content("Mr. Pirate")
      end
    end

    it "returns a message when no search results are input" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("No results input to search")
    end

    it "returns a pet with case insensitive search" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "mr. pirate")

      click_button("Search")

      within("#pet_search_results-#{@pet_1.id}") do
        expect(page).to have_content("Mr. Pirate")
      end
    end

    it "returns a pet with partial search" do 
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "Mr.")

      click_button("Search")

      within("#pet_search_results-#{@pet_1.id}") do
        expect(page).to have_content("Mr. Pirate")
      end
    end
  end

  describe "Add pet to application" do
    it "adds a pet to the application when the adopt a pet button is clicked" do
      visit "/applications/#{@application_1.id}"

      fill_in(:search, with: "Mr. Pirate")

      click_button("Search")

      within("#pet_search_results-#{@pet_1.id}") do
        expect(page).to have_content("Mr. Pirate")
      end
      
      click_button("Adopt this Pet")

      expect(@application_1.pets).to eq([@pet_1])

      within("#pets_applied_for") do 
        expect(page).to have_content(@pet_1.name)
      end
    end
  end
  
  describe "submit application" do 
    it "not have a section to submit if not pets are selected" do 
      visit "/applications/#{@application_1.id}"
      
      expect(page).to_not have_content("Why would you make a good owner for these pet(s)?")
    end
    
    it "has a section to submit once a pet is added to the application" do 
      visit "/applications/#{@application_1.id}"
      fill_in(:search, with: "Mr. Pirate")
      
      click_button("Search")
      click_button("Adopt this Pet")
      
      expect(page).to have_content("Why would you make a good owner for these pet(s)?")
    end
    
    it "populates 'Reason for adoption' once submitted" do 
      visit "/applications/#{@application_1.id}"
      fill_in(:search, with: "Mr. Pirate")
      
      click_button("Search")
      click_button("Adopt this Pet")
      
      fill_in(:adoption_reason, with: "I like turtles")
      click_button("Submit")
      
      expect(current_path).to eq("/applications/#{@application_1.id}")
      
      within("#applicant_info-#{@application_1.id}") do 
        expect(page).to have_content("I like turtles")
      end
    end
  
    it "changes status to pending once the application is submitted" do 
      visit "/applications/#{@application_1.id}"

      within("#applicant_info-#{@application_1.id}") do 
        expect(page).to have_content("In Progress")
      end

      fill_in(:search, with: "Mr. Pirate")
      
      click_button("Search")
      click_button("Adopt this Pet")
      
      fill_in(:adoption_reason, with: "I like turtles")
      click_button("Submit")
      
      expect(current_path).to eq("/applications/#{@application_1.id}")

      within("#applicant_info-#{@application_1.id}") do 
        expect(page).to have_content("Pending")
      end
    end
  end
end