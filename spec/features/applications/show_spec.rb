require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet = @shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
  end

  describe "US 1 - When I visit an applications show page" do
    it "I can see the application attributes" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip_code)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
    end
  end

  describe "US 4 - When I visit an applications show page" do
    describe "that application has not been submitted" do
      describe " see a section on the page to 'Add a Pet to this Application'" do
        describe "In that section I see an input where I can search for Pets by name" do
          describe " I fill in this field with a Pet's name and I click submit" do
            it " I am taken back to the application show page and under the search bar I see any Pet whose name matches my search" do
              visit "/applications/#{@application.id}"

              expect(page).to have_content("Add a Pet to this Application")
              fill_in "Search for Pets", with: "Scooby"
              click_button "Submit"

              expect(current_path).to eq("/applications/#{@application.id}")

              expect(page).to have_content("Scooby")
            end
          end
        end
      end
    end
  end

  describe "US 5 - When I visit an applications show page" do
    describe "I search for a Pet by name" do
      describe "I see the names Pets that match my search" do
        describe "Next to each Pet's name I see a button to 'Adopt this Pet', I click one of these buttons" do
          it "I am taken back to the application show page and I see the Pet I want to adopt listed on this application" do
            visit "/applications/#{@application.id}"

            fill_in "Search for Pets", with: "Scooby"
            click_button "Submit"

            expect(page).to have_button("Adopt this Pet")
            click_button("Adopt this Pet")

            expect(current_path).to eq("/applications/#{@application.id}")
            expect(page).to have_content("#{@pet.name}")
          end
        end
      end
    end
  end
end
