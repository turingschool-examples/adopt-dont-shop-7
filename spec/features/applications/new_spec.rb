require "rails_helper"

RSpec.describe "Application New Page" do
  describe "As a visitor, when I visit the pet index page" do   
    before(:each) do
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
    end

    describe "When I visit the pet index page" do
      it "I see a link to Start an Application, and I click this link, then I am taken to the new application page where I see a form" do

        visit "/pets"
        expect(page).to have_link("Start an Application")
        click_link("Start an Application")
        expect(current_path).to eq("/applications/new")

        expect(page).to have_content("New Application")
      end

      it "When I fill in this form with ALL of my information, and click submit, I am taken to the new app show page where I see 'in progress' application" do

        visit "/applications/new"
        save_and_open_page

        fill_in("name", with: "Billy")
        fill_in("street", with: "Maritime Lane")
        fill_in("city", with: "Springfield")
        fill_in("state", with: "Virginia")
        fill_in("zip", with: "22153")
        fill_in("description", with: "Loving and likes to walk")

        click_on("Submit Application")
        expect(current_path).to eq("/applications/#{Application.last.id}")

        expect(page).to have_content("Billy")
        expect(page).to have_content("Maritime Lane Springfield Virginia 22153")
        expect(page).to have_content("Loving and likes to walk")
        save_and_open_page

        expect(page).to have_content("In Progress")
      end
    end
  end
end