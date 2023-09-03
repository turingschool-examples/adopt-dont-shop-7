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
      # save_and_open_page
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

  describe "When I visit an application's show page" do
    it "I see a section on the page to 'Add a Pet to this Application'" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("Search by Name")
      expect(page).to have_button("Search")
    end

    it "should return searched pet results" do
      visit "/applications/#{@application_1.id}"
      fill_in "Search by Name", with: "Lasagna"
      click_button("Search")

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@pet_4.name) # Lasagna
      expect(page).to_not have_content(@pet_3.name) # Sylvester
    end
    
    it "shows and 'Adopt this pet' button next to each pet's name" do
      visit "/applications/#{@application_1.id}"
      fill_in "Search by Name", with: "Lasagna"
      click_button("Search")

      within("#pet_adoption") do
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_button("Adopt this Pet")
        click_button("Adopt this Pet")
      end
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@pet_4.name) # Lasagna
      expect(@application_1.pets).to include(@pet_4)
    end
  end

  describe "when visiting the application's show page and I have added pets to the applications" do
    it "has a section to submit the application that has an input to describe why the user would be a good owner" do
      visit "/applications/#{@application_1.id}"
      expect(@application_1.pets).to_not be_empty
      expect(@application_1.status).to eq("In Progress")
      
      within("#submit_application") do
       expect(find("form")).to have_content("Qualification")
      end
    end

    it "when the user fills in the form and clicks submit" do
      visit "/applications/#{@application_1.id}"

      within("#submit_application") do
        fill_in "Qualification", with: "I'm a pro"
        click_button("Submit Application")
        @application_1.reload
      end
      
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(@application_1.status).to eq("Pending")
      expect(page).to have_content("Pending")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to_not have_button("Search")
      expect(page).to_not have_field("Qualification")
    end
  end
end