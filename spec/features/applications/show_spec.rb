require "rails_helper"

RSpec.describe "Application Show Page" do
#   1. Application Show Page
  describe "As a visitor" do
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
  end
# 
# 
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
end