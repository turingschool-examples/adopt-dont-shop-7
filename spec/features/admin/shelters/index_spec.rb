require 'rails_helper' 

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  
    
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

    @application_1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "Pending")
    @application_2 = Application.create(name: "Jacob", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "Pending")
    @application_3 = Application.create(name: "Jingle", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application_4 = Application.create(name: "Pending", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application_5 = Application.create(name: "Schmit", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "Pending")

    @pet_app_1 = PetApplication.create!(application_id: "#{@application_1.id}", pet_id: "#{@pet_3.id}", status: "Pending")
    @pet_app_2 = PetApplication.create!(application_id: "#{@application_2.id}", pet_id: "#{@pet_1.id}", status: "Pending")
    @pet_app_3 = PetApplication.create!(application_id: "#{@application_3.id}", pet_id: "#{@pet_3.id}", status: "Pending")
    @pet_app_4 = PetApplication.create!(application_id: "#{@application_4.id}", pet_id: "#{@pet_2.id}", status: "Pending")
  end 
  
  it "lists all the shelter names in reverse alphabetical order" do
   
    visit "/admin/shelters"
    
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_1.name)
  end

  it "has a section listing the names of all shelters with pending applications" do 
    visit "/admin/shelters"
  # 
    within "#shelters_with_pending_apps" do
      expect(page).to have_content("Shelters with pending applications:")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
    end
  end
end 