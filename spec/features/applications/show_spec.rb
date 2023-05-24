require "rails_helper"

RSpec.describe "/applications/:id", type: :feature do 
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create!(name: "Fluffy", breed: "british shorthair", age: 1, adoptable: true)
    @pet_5 = @shelter_1.pets.create!(name: "Flabbergast", breed: "anybody's guess", age: 4, adoptable: true)

    @susie = Application.create!(
      name: "Susie", 
      street_address: "5234 S Jamaica", 
      city: "Fargo", 
      state: "MI", 
      zip: "45896", 
      description: "Loves alligators.", 
      status: "Accepted"
    )

    @tom = Application.create!(
      name: "Thomas", 
      street_address: "5234 S Jefferson", 
      city: "Julian", 
      state: "AL", 
      zip: "43896", 
      description: "Has owned a pet.", 
      status: "In Progress"
    )

    @jeremicah = Application.create!(
      name: "Jeremicah", 
      street_address: "9876 W Holburn Ave", 
      city: "Gertrude", 
      state: "NY", 
      zip: "10092", 
      description: "A little quirky", 
      status: "In Progress"
    )
    
    ApplicationPet.create!(pet: @pet_1, application: @susie)
    ApplicationPet.create!(pet: @pet_2, application: @susie)
    
    ApplicationPet.create!(pet: @pet_1, application: @tom)
    ApplicationPet.create!(pet: @pet_2, application: @tom)
    ApplicationPet.create!(pet: @pet_3, application: @tom)

    ApplicationPet.create!(pet: @pet_1, application: @jeremicah)
  end

  #User story 1
  describe "Application Show Page" do
    it "shows applicant information" do 
      visit "/applications/#{@susie.id}"
      
      within("#applicant-info") do 
        expect(page).to have_content(@susie.name)
        expect(page).to have_content("Street Address: #{@susie.street_address}")
        expect(page).to have_content("City: #{@susie.city}")
        expect(page).to have_content("State: #{@susie.state}")
        expect(page).to have_content("Zip Code: #{@susie.zip}")
        expect(page).to have_content("Description: #{@susie.description}")
        
        expect(page).to_not have_content(@tom.name)
        expect(page).to_not have_content("Street Address: #{@tom.street_address}")
        expect(page).to_not have_content("City: #{@tom.city}")
        expect(page).to_not have_content("State: #{@tom.state}")
        expect(page).to_not have_content("Zip Code: #{@tom.zip}")
        expect(page).to_not have_content("Description: #{@tom.description}")
      end

      expect(page).to have_content("Status: #{@susie.status}")
      expect(page).to_not have_content("Status :#{@tom.status}")
    end
    
    it 'shows different applicant information' do 
      visit "/applications/#{@tom.id}"
      within("#applicant-info") do 
        expect(page).to have_content(@tom.name)
        expect(page).to have_content("Street Address: #{@tom.street_address}")
        expect(page).to have_content("City: #{@tom.city}")
        expect(page).to have_content("State: #{@tom.state}")
        expect(page).to have_content("Zip Code: #{@tom.zip}")
        expect(page).to have_content("Description: #{@tom.description}")
        
        expect(page).to_not have_content(@susie.name)
        expect(page).to_not have_content("Street Address: #{@susie.street_address}")
        expect(page).to_not have_content("City: #{@susie.city}")
        expect(page).to_not have_content("State: #{@susie.state}")
        expect(page).to_not have_content("Zip Code: #{@susie.zip}")
        expect(page).to_not have_content("Description:#{@susie.description}")
      end 

      within("#pets-links") do 
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_3.name)
      end
      
      expect(page).to have_content("Status: #{@tom.status}")
      expect(page).to_not have_content("Status:#{@susie.status}")
    end

    it 'displays a link to each pet show page' do 
      visit "/applications/#{@susie.id}"
      within("#pets-links") do 
        expect(page).to have_link("#{@pet_1.name}", :href => "/pets/#{@pet_1.id}")
        expect(page).to have_link("#{@pet_2.name}", :href => "/pets/#{@pet_2.id}")
        
        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
    end
  end

  # User Story 4
  describe "Searching for Pets for an Applicatioin" do
    it "displays an 'Add a Pet' section if the application has not been submitted (status = 'In Progress')" do 
      visit "/applications/#{@tom.id}"
      expect(page).to have_content("Status: In Progress")
      within("#add-a-pet") do 
        expect(page).to have_content("Add a Pet to this Application")
      end
      
      visit "/applications/#{@susie.id}"
      expect(page).to have_content("Status: Accepted")
     
      within("#add-a-pet") do 
        expect(page).to_not have_content("Add a Pet to this Application")
      end
    end

    it "successfully searches for a pet by name and display it below search bar" do
      visit "/applications/#{@tom.id}"
      within("#add-a-pet") do 
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_button("Search")
        expect(page).to_not have_content(@pet_4.name)
        
        fill_in("Search", with: @pet_4.name)
        click_button("Search")
      end

      expect(current_path).to eq("/applications/#{@tom.id}")

      within("#search-pets") do
        expect(page).to have_content(@pet_4.name)
      end
    end
    
    it "unsuccessfully searches for a pet by name and does not display it" do
      visit "/applications/#{@tom.id}"
      within("#add-a-pet") do 
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_button("Search")
        expect(page).to_not have_content("Spot")
        
        fill_in("Search", with: "Spot")
        click_button("Search")
      end
      
      expect(current_path).to eq("/applications/#{@tom.id}")
      within("#search-pets") do
        expect(page).to_not have_content("Spot")
      end
    end
  end

  #User Story 5
  describe 'Add a Pet to an Application' do 
    it 'pets searched for and returned can be added to application' do 
      visit "/applications/#{@jeremicah.id}" 
      expect(page).to_not have_content("Flabbergast")
      expect(page).to_not have_button("Adopt this Pet")
      
      fill_in('Search', with: @pet_5.name) 
      click_button('Search')
      
      expect(page).to have_content(@pet_5.name)
      expect(page).to have_content("Flabbergast")
      expect(page).to have_button('Adopt this Pet')
      click_button('Adopt this Pet')
      expect(current_path).to eq("/applications/#{@jeremicah.id}")
      expect(page).to have_content(@pet_5.name)
    end
  end

#   #User Story 6
  describe "submit application" do 
    it "if conditions not met, cannot submit application with justification for ownership" do 
      visit "/applications/#{@susie.id}"

      expect(page).to have_content("Status: Accepted")
      within("#application-submission") do 
        expect(page).to_not have_field("Reason for Adoption")
        expect(page).to_not have_button("Submit Application")
      end
    end

    it "if conditions met (1 pet), can submit application with justification for ownership" do 
      visit "/applications/#{@jeremicah.id}"

      expect(page).to have_content("Status: In Progress")
      expect(page).to_not have_content("Status: Pending")

      within("#application-submission") do 
        expect(page).to have_content("Reason for Adoption")
        expect(page).to have_field(:reason)
        expect(page).to have_button("Submit Application")

        fill_in(:reason, with: "I love this animal. It reminds me of me.")
        click_button("Submit Application")
      end

      expect(current_path).to eq("/applications/#{@jeremicah.id}")
      expect(page).to have_content("Status: Pending")
      expect(page).to_not have_content("Status: In Progress")
      
      within("#pets-links") do 
        expect(page).to have_content(@pet_1.name)
      end

      within("#search-pets") do
        expect(page).to_not have_button("Search")
        expect(page).to_not have_field(:search)
        expect(page).to_not have_button("Adopt this Pet")
      end
    end

    it "if conditions met (>1 pet), can submit application with justification for ownership" do 
      visit "/applications/#{@jeremicah.id}"

      within("#add-a-pet") do
        fill_in('Search', with: @pet_5.name) 
        click_button('Search')
      end

      within("#search-pets") do 
        click_button('Adopt this Pet')
      end

      expect(page).to have_content("Status: In Progress")
      expect(page).to_not have_content("Status: Pending")

      within("#application-submission") do 
        expect(page).to have_field(:reason)
        expect(page).to have_button("Submit Application")
    
        fill_in(:reason, with: "I love this animal. It reminds me of me.")
        click_button("Submit Application")
      end

      expect(current_path).to eq("/applications/#{@jeremicah.id}")
      expect(page).to have_content("Status: Pending")
      expect(page).to_not have_content("Status: In Progress")
    
      within("#pets-links") do 
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_5.name)
      end

      within("#search-pets") do
        expect(page).to_not have_button("Search")
        expect(page).to_not have_field(:search)
        expect(page).to_not have_button("Adopt this Pet")
      end
    end
  end

  #User Story 7
  describe 'No Pets on an Application ' do 
    it 'if an application has no pets, cannot submit application' do 
      samanthony = Application.create!(
        name: "Samanthony", 
        street_address: "5234 S Jupiter", 
        city: "Fort Collins", 
        state: "CO", 
        zip: "80524", 
        description: "Exceptionally quirky", 
      )
      visit "/applications/#{samanthony.id}"

      within("#application-submission") do
        expect(page).to_not have_field(:reason)
        expect(page).to_not have_content("Submit Application")
      end
    end
  end

  # User Story 8
  describe "Partial Matches for Pet Names" do 
    it "search returns results for partial matches" do 
      visit "/applications/#{@jeremicah.id}" 

      within("#search-pets") do 
        expect(page).to_not have_content(@pet_2.name)
      end
      
      within("#add-a-pet") do 
        fill_in('Search', with: 'aw')
        click_button('Search')
      end

      within("#search-pets") do 
        expect(page).to have_content(@pet_2.name)
      end

      within("#add-a-pet") do
        fill_in('Search', with: 'fl')
        click_button('Search')
      end

      within("#search-pets") do
        expect(page).to have_content(@pet_4.name)
        expect(page).to have_content(@pet_5.name)
      end
    end
  end

  #User Story 9
  describe "Case Insensitive Matches for Pet Names" do 
    it 'search returns relevant results regardless of case' do 
      visit "/applications/#{@jeremicah.id}" 

      within("#search-pets") do   
        expect(page).to_not have_content("Clawdia")
        expect(page).to_not have_content(@pet_2.name)
      end

      within("#add-a-pet") do 
        fill_in('Search', with: 'clawdia')
        click_button('Search')
      end

      within("#search-pets") do
        expect(page).to have_content("Clawdia")
        expect(page).to have_content(@pet_2.name)
      end  
      
      within("#search-pets") do 
        expect(page).to_not have_content("Fluffy")
        expect(page).to_not have_content(@pet_4.name)
        expect(page).to_not have_content("Flabbergast")
        expect(page).to_not have_content(@pet_5.name)
      end

      within("#add-a-pet") do
        fill_in('Search', with: 'fL')
        click_button('Search')
      end

      within("#search-pets") do 
        expect(page).to have_content("Fluffy")
        expect(page).to have_content(@pet_4.name)
        expect(page).to have_content("Flabbergast")
        expect(page).to have_content(@pet_5.name)
      end
    end
  end
end