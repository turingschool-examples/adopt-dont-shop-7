require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  end

  describe "Admin Shelters Index" do 
    describe "I visit the admin shelter index ('/admin/shelters')" do 
      it "I see all Shelters in the system listed in reverse alphabetical order by name" do
        visit '/admin/shelters'

        expect(page).to have_content("RGV animal shelter")
        expect(page).to have_content("Fancy pets of Colorado")
        expect(page).to have_content("Aurora shelter")
      end
    end
  end

  describe "I visit the admin shelters index" do 
    describe "Then I see a section for 'Shelters with Pending Applications'" do 
      it "I see the name of every shelter that has a pending application" do 
        @application = Application.create!(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")

        visit "/applications/#{@application.id}"

        fill_in "Search for Pets", with: "Clawdia"

        click_button "Submit"

        click_button "Adopt this Pet"
        
        expect(page).to have_content("Why would you make a good owner for these pet(s)?")

        expect(page).to have_button("Submit Application")

        fill_in "Why would you make a good owner for these pet(s)?", with: "I love animals"

        click_button("Submit Application")

        visit '/admin/shelters'
save_and_open_page
        expect(page).to have_content(@shelter_1.name)

      end
    end
  end
end
