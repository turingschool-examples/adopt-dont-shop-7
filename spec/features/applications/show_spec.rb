require "rails_helper"

RSpec.describe "Application show page" do

  before :each do
    @happy = Shelter.create!({
      name: "Happy Cats and Dogs",
      foster_program: true,
      city: "Boulder",
      rank: 12
    })
    
    @butler = @happy.pets.create!({
      name: "Butler",
      adoptable: true,
      age: 9,
      breed: "Labradoodle"
    })
    
    @porter = @happy.pets.create!({
      name: "Porter",
      adoptable: false,
      age: 1,
      breed: "Pit Mix"
    })
    
    @juniper = @happy.pets.create!({
      name: "Juniper",
      adoptable: true,
      age: 3,
      breed: "American Shorthair"
    })
    
    @tonic = @happy.pets.create!({
      name: "Tonic",
      adoptable: true,
      age: 3,
      breed: "American Shorthair"
    })
    
    @jericho = @happy.pets.create!({
      name: "Jericho",
      adoptable: false,
      age: 5,
      breed: "Turtle"
    })
    
    @billy = Application.create!({
      name: "Billy the Kid",
      street_address: "123 ABC St",
      city: "Boulder",
      state: "CO",
      zip_code: "12345",
      reason_for_adoption: "Bank robbing alert dog",
      status: "In Progress"
    })
    
    @peggy = Application.create!({
      name: "Peggy Sue",
      street_address: "456 Main St",
      city: "Longmont",
      state: "CO",
      zip_code: "34567",
      reason_for_adoption: "I'm a lonely old lady",
      status: "In Progress"
    })
    
    @balthazar = Application.create!({
      name: "Balthazar",
      street_address: "666 Demon Blvd",
      city: "Greely",
      state: "CO",
      zip_code: "66666",
      reason_for_adoption: "I've always wanted a turtle",
      status: "In Progress"
    })
  end

  it "will show the info of an applicant" do
    visit "/applications/#{@billy.id}"

    expect(page).to have_content(@billy.name)
    expect(page).to have_content(@billy.reason_for_adoption)
    expect(page).to have_content(@billy.status)
    expect(page).to have_content("#{@billy.street_address}, #{@billy.city}, #{@billy.state} #{@billy.zip_code}")
    expect(page).to have_content(@billy.name)
    expect(page).to have_content(@billy.name)
  end
#user story 4
describe "Application search and add pet" do
  before(:each) do
    PetApplication.destroy_all
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
    @pet = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
    @applicant_1 = Application.create!(name: 'Steven', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "In Progress"
      )
      PetApplication.create!(pet_id: @pet.id, application_id: @applicant_1.id, status: "Pending")
    end

    it "displays a section on the show page to add a pet to this application" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_content('Add a Pet to this Application')
    end

    it "has a search button" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_button("Search")
    end

    it "When the user fills in this field with a pet name, and clicks search, then they are taken back to the application show page" do
      visit "/applications/#{@applicant_1.id}"

      fill_in("Search", with: "Hank")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@applicant_1.id}")
    end

  end
  #user story 5
  it "adds pet to the application" do
    @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
    @pet = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
    @applicant_1 = Application.create!(name: 'Steven', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "In Progress"
      )

    visit "/applications/#{@applicant_1.id}"

    fill_in "Search", with: "Hank"
    click_button("Search")

    click_button("Adopt this Pet")
    expect(@applicant_1.pets.to_a).to eq([@pet])
    expect(page).to have_content("Hank")
  end
  #User Story 6
  it "has a submit section when a pet is added" do 
    @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
    @pet = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
    @applicant_1 = Application.create!(name: 'Steven', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "In Progress"
      )
      PetApplication.create!(pet_id: @pet.id, application_id: @applicant_1.id, status: "Pending")

     visit "/applications/#{@applicant_1.id}"

      expect(page).to have_content("Hank")
      expect(page).to have_content("In Progress")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field(:reason_for_adoption)

      fill_in(:reason_for_adoption, with: "I have a huge yard")
      expect(page).to have_button("Submit")
      click_button("Submit")

      expect(current_path).to eq("/applications/#{@applicant_1.id}")
      expect(page).to have_content("Pending")
      expect(page).to_not have_content("In Progress")
      expect(page).to have_content("I have a huge yard")

      expect(page).to_not have_content("Add a Pet to this Application")
    end
end