require "rails_helper"

RSpec.describe "application" do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "County Pet Shelter", city: "Denver", rank: 1)
    @shelter = Shelter.create!(name: "Heavenly pets", city: "Aurora, CO", foster_program: true, rank: 7)
    @app_1 = Application.create!(name: "John Smith", address: "123 Main", city: "Anytown", state: "CO", zip_code: "80000", description: "Because I have a house", application_status: "In Progress")
    @pet = Pet.create!(adoptable: true, age: 3, breed: "GSD", name: "Charlie", shelter_id: @shelter.id)
    @pet_1 = Pet.create!(adoptable: true, age: 2, breed: "Golden Retriever", name: "Rover", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 1, breed: "Maine Coon", name: "Kitty", shelter_id: @shelter_1.id)
    @app_1_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @app_1.id)
  end
  it "displays a link to all pets" do
    visit "/"
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path("/pets")
  end

  it "displays a link to all shelters" do
    visit "/"

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path("/shelters")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinary offices" do
    visit "/"

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path("/veterinary_offices")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinarians" do
    visit "/"

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path("/veterinarians")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  describe "When I visit an applications show page, Then I can see the following:" do
    it "Name of the Applicant, Full Address of the Applicant including street address, city, state, and zip code, Description of why the applicant says they'd be a good home for this pet(s) names of all pets that this application is for (all names of pets should be links to their show page), The Application's status, either 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
      visit ("/applications/#{@app_1.id}")

      expect(page).to have_content("#{@app_1.name}")
      expect(page).to have_content("#{@app_1.address}")
      expect(page).to have_content("#{@app_1.city}")
      expect(page).to have_content("#{@app_1.state}")
      expect(page).to have_content("#{@app_1.zip_code}")
      expect(page).to have_content("#{@app_1.description}")
      expect(page).to have_content("#{@app_1.application_status}")
      expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      expect(page).to_not have_content("#{@pet_2.name}")

    end
  end

  describe "When I visit an application's show page" do
    before (:each) do
      visit ("/applications/#{@app_1.id}")
    end
    describe "And that application has not been submitted" do
      it "Then I see a section on the page to 'Add a Pet to this Application'" do
        expect(page).to have_content("Add a Pet to this Application")
      end

      it "I see an input where I can search for Pets by name When I fill in this field with a Pet's name And I click submit, Then I am taken back to the application show page And under the search bar I see any Pet whose name matches my search" do
        expect(find("#pet_search")).to have_content("Search for pet")
        fill_in "Name", with: "Charlie"
        click_button "Submit"
        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Charlie")
      end
    end

    describe "And I search for a Pet by name" do
      it "And I see the names Pets that match my search" do
        expect(page).to have_content("#{@pet_1.name}")
        expect(page).to_not have_content("#{@pet_2.name}")

        fill_in "Name", with: "Charlie"
        click_button "Submit"

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Charlie")
      end

      it "Then next to each Pet's name I see a button to 'Adopt this Pet'" do
        fill_in "Name", with: "Charlie"
        click_button "Submit"

        expect(page).to have_button("Adopt this Pet")
      end

      it "When I click one of these buttons Then I am taken back to the application show page And I see the Pet I want to adopt listed on this application" do
        fill_in "Name", with: "Charlie"
        click_button "Submit"
        click_button "Adopt this Pet"
        
        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("#{@pet_1.name}")
        expect(page).to have_content("#{@pet.name}")
        expect(page).to_not have_content("#{@pet_2.name}")
      end
    end

    describe "And I have added one or more pets to the application" do
      it "I see a section to submit my application And in that section I see an input to enter why I would make a good owner for these pet(s)" do
        expect(page).to have_content("Submit my application")
        expect(find("#submit_application")).to have_field("description", type: "textarea")
      end
      
      it "When I fill in that input And I click a button to submit this application
      Then I am taken back to the application's show page
      And I see an indicator that the application is 'Pending'
      And I see all the pets that I want to adopt
      And I do not see a section to add more pets to this application" do
        fill_in "description", with: "I can afford food"
        click_button "Submit my application"
        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Application Status: Pending")
        expect(page).to have_content("Rover")
        expect(page).to have_content("I can afford food")
        expect(page).to_not have_content("Add a Pet to this Application")
        save_and_open_page
      end
    end
  end
end
