require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before(:each) do
    @application = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    @application_2 = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "England", zip: "48", description: "I still believe love is all you need.  I don't know a better message than that.", status: "Pending")
    
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chiwawa", name: "Bamby", shelter_id: @shelter.id)

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

      describe "when the application has not been submitted" do
        it "has a section that says 'Add a Pet to this Application'" do
          visit "/applications/#{@application.id}"
          
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Pet Search")

          visit "/applications/#{@application_2.id}"
          
          expect(page).to_not have_content("Add a Pet to this Application")
          expect(page).to_not have_field("Pet Search")
        end
        
        it "redirects_to the application show page after filling in Pet's name" do
          visit "/applications/#{@application.id}"

          expect(page).to_not have_content(@pet_3.name)
          fill_in "Pet Search", with: "Ba"
          click_button "Submit"

          expect(current_path).to eq("/applications/#{@application.id}")
          expect(page).to have_content(@pet_3.name)
        end
      end
    end
  end
end