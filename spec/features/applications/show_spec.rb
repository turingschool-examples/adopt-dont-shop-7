require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before(:each) do
    @application = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)

    @app_pet_1 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_1.id)
    @app_pet_2 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_2.id)
  end

  describe "as a visitor" do
    describe "when visiting applicaiton show page" do
      it "I can see applicant details" do
        
        visit "/applications/#{@application.id}"

        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.street)
        expect(page).to have_content(@application.city)
        expect(page).to have_content(@application.state)
        expect(page).to have_content(@application.zip)
        expect(page).to have_content(@application.description)
        expect(page).to have_content(@application.status)
      end

      it "I can see the names of all pets this application is for with links to their show page" do

        visit "/applications/#{@application.id}"

        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
        
        expect(page).to have_link(@pet_1.name)
        click_link @pet_1.name
        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit "/applications/#{@application.id}"

        expect(page).to have_link(@pet_2.name)
        click_link @pet_2.name
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
    end
  end
end