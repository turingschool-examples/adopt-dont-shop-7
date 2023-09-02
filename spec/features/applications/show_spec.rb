require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: @shelter.id)
    @application_1 = Application.create!(name: "Peter Griffin", street: "200 Park Road", city: "Quahog", state: "MA", zip_code: "09876", description: "I like animals", status: "In Progress")
    @application_2 = Application.create!(name: "Quagmire", street: "300 Crest Lane", city: "Lowell", state: "NY", zip_code: "12345", description: "Giggity", status: "Pending")
    @apply_1 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @apply_2 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_2.id)
  end

  describe "When I visit an applications show page" do
    it "I can see applicant details" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip_code)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)

      expect(page).to_not have_content(@application_2.name)
    end

    it "shows the names of all pets that this application is for" do
      visit "/applications/#{@application_1.id}"
      save_and_open_page
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      
      expect(page).to have_link(@pet_1.name)
      click_link("#{@pet_1.name}")
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      
      visit "/applications/#{@application_1.id}"
      expect(page).to have_link(@pet_2.name)
      click_link("#{@pet_2.name}")
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end
  end
end