require "rails_helper"

RSpec.describe "pet creation" do
  before(:each) do
    @app_1 = Application.create!(name: "Susan", 
      street: "7654 Clover St", 
      city: "Denver", 
      state: "CO", 
      zip: "80033", 
      descr: "I love animals and am lonely")

    @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
   
    @pet_1_app =PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id)
    @app_1.pets << @pet_2
    @app_1.pets << @pet_3
  end

    it "has a applications show page" do
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # Name of the Applicant
    # Full Address of the Applicant including street address, city, state, and zip code
    # Description of why the applicant says they'd be a good home for this pet(s)
    # names of all pets that this application is for (all names of pets should be links to their show page)
    # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
      
    visit "/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.street)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      expect(page).to have_content(@app_1.descr)
    end

    it "shows the names of all pets on the application and their status" do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content("Lucille Bald")
      # expect(page).to have_content("In Progress")

      expect(page).to have_content("Lobster")
      # expect(page).to have_content("In Progress")

      expect(page).to have_content("Beethoven")
      # expect(page).to have_content("In Progress")
    end
end