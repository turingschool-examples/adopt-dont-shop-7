require "rails_helper"

RSpec.describe "Applicants Show Page", type: :feature do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @rex = @shelter.pets.create!(adoptable: true, age: 2, breed: "Dog", name: "Rex" )
  end

  describe "As a visitor" do
    describe "When I visit an applicants show page" do
      it "displays the name, full address, description, pets that its for, and the app status" do
        visit "/applicants/#{@bob.id}"

        expect(page).to have_content("#{@bob.name}")
        expect(page).to have_content("#{@bob.street_address}")
        expect(page).to have_content("#{@bob.city}")
        expect(page).to have_content("#{@bob.state}")
        expect(page).to have_content("#{@bob.zip_code}")
        expect(page).to have_content("#{@bob.description}")
        expect(page).to have_content("#{@bob.application_status}")
      end

      describe "And that application has not been submitted" do
        it "Then I see a section on the page to 'Add a Pet to this Application'" do
          visit "/applicants/#{@bob.id}"

          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("pet_name")

          fill_in "pet_name", with: "Rex"

          click_button "Submit"

          expect(current_path).to eq("/applicants/#{@bob.id}")

          expect(page).to have_content("#{@rex.name}")
          expect(page).to have_content("Age: #{@rex.age}")
          expect(page).to have_content("Breed: #{@rex.breed}")
          expect(page).to have_content("Adoptable: #{@rex.adoptable}")
        end
      end
    end
  end
end