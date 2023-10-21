require "rails_helper"

RSpec.describe "Application Show Page" do

  describe "User Story 1: As a visitor" do
    before(:each) do
      @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "Pending")
      @application_2 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      @application_3 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "Accepted")
      @application_4 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "Rejected")
      
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)

      @pet_1.applications << @application_1
      @pet_2.applications << @application_1
      @pet_3.applications << @application_1
    end


    describe "When I visit an applications show page" do
      it "I can see Applicant name, address, description" do

        visit "/applications/#{@application_1.id}"

        expect(page).to have_content(@application_1.name)
        expect(page).to have_content("#{@application_1.street} #{@application_1.city} #{@application_1.state} #{@application_1.zip}")
        expect(page).to have_content(@application_1.description)
      end

      it "shows names of all pets and links to their show page" do

        visit "/applications/#{@application_1.id}"

        expect(page).to have_link("#{@pet_1.name}")
        expect(page).to have_link("#{@pet_2.name}")
        expect(page).to have_link("#{@pet_3.name}")

        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit "/applications/#{@application_1.id}"

        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")

        visit "/applications/#{@application_1.id}"

        click_link("#{@pet_3.name}")
        expect(current_path).to eq("/pets/#{@pet_3.id}")
      end

      it "shows the Application's status as 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do

        visit "/applications/#{@application_1.id}"
        expect(page).to have_content("Pending")

        visit "/applications/#{@application_2.id}"
        expect(page).to have_content("In Progress")

        visit "/applications/#{@application_3.id}"
        expect(page).to have_content("Accepted")

        visit "/applications/#{@application_4.id}"
        expect(page).to have_content("Rejected")

      end
    end

    describe "User Story 4. Searching for Pets for an Application" do
      before(:each) do
        @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
        
        @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  
        @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
        @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
        @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
      end

      describe "As a visitor, when I visit an app show page that has not been submitted" do
        it "I see a section (form) on the page to 'Add a Pet' and an input where I can search for Pets by name" do
          visit "/applications/#{@application_1.id}"
          expect(page).to have_content("Add a Pet")
          expect(page).to have_button("Search")
        end

        it "When I fill in this field with a Pet's name and I click submit, then I am taken back to the application show page, and I see pets whose name match" do
          visit "/applications/#{@application_1.id}"
          fill_in "Search", with: "Ba"
          click_on("Search")

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to_not have_content(@pet_3.name)
        end
      end

      describe "User Story 5: Add a Pet to an Application" do
        describe "As a visitor, when I visit an application's show page, search and see pets that match that search" do
          it "Next to each Pet's name I see a button to 'Adopt this Pet'" do
            visit "/applications/#{@application_1.id}"
            fill_in "Search", with: "Ba"
            click_on("Search")

            within "#pet-#{@pet_1.id}" do
              expect(page).to have_selector(:link_or_button, "Adopt this Pet")
            end

            within "#pet-#{@pet_2.id}" do
              expect(page).to have_selector(:link_or_button, "Adopt this Pet")
            end
          end

          it "When I click 'Adopt this Pet' I am taken back to the application show page and see the Pet I want to adopt listed on this application" do
            visit "/applications/#{@application_1.id}"
            fill_in "Search", with: "Ba"
            click_on("Search")

            within "#pet-#{@pet_1.id}" do
              click_button("Adopt this Pet")
            end

            expect(current_path).to eq("/applications/#{@application_1.id}")

            expect(page.find("#petlist-#{@pet_1.id}")).to be(true)
          end
        end
      end
    end
  end
end