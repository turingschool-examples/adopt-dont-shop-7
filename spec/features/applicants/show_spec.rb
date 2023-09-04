require "rails_helper"

RSpec.describe "Applicants Show Page", type: :feature do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @rex = @shelter.pets.create!(adoptable: true, age: 2, breed: "Dog", name: "Rex" )
    @floof = @shelter.pets.create!(adoptable: true, age: 3, breed: "English Bulldog", name: "Floof")
    @fluffy = @shelter.pets.create!(adoptable: true, age: 4, breed: "Three-Headed Dog", name: "FlUfFy")
    @fluff = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pomeranian", name: "FLUFF")
    @mr_fluff = @shelter.pets.create!(adoptable: true, age: 3, breed: "Great Dane", name: "Mr. FluFF")
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

        describe "And I search for a Pet by name and I see the names of the Pets that match my search" do
          it "displays a button to 'Adopt this Pet' next to each Pets name" do
            visit "/applicants/#{@bob.id}?pet_name=#{@rex.name}&commit=Submit"

            expect(page).to have_button("Adopt this Pet")
          end

          it "displays any pet whose name PARTIALLY matches my search and my search is case insensitive" do
            visit "/applicants/#{@bob.id}"

            fill_in "pet_name", with: "fluff"

            click_button "Submit"

            expect(page).to have_content("#{@fluffy.name}")
            expect(page).to have_content("#{@fluff.name}")
            expect(page).to have_content("#{@mr_fluff.name}")
            expect(page).to_not have_content("#{@rex.name}")
            expect(page).to_not have_content("#{@floof.name}")
          end

          describe "When I click one of these buttons" do
            it "takes me back to the application show page and I see the Pet I want to adopt listed on this application" do
              visit "/applicants/#{@bob.id}?pet_name=#{@rex.name}&commit=Submit"

              click_on "Adopt this Pet"

              expect(current_path).to eq("/applicants/#{@bob.id}")

              expect(page).to have_content("Pets being applied for:")
              expect(page).to have_content("#{@rex.name}")
              expect(page).to have_content("Age: #{@rex.age}")
              expect(page).to have_content("Breed: #{@rex.breed}")
              expect(page).to have_content("Adoptable: #{@rex.adoptable}")
            end
          end
        end
      end
      #user story 6 and 7
      describe "Then I see a section to submit my application" do
        it "And in that section I see an input to enter why I would make a good owner for these pet(s)" do
          visit "/applicants/#{@bob.id}"
          
          expect(page).to_not have_content("Submit Application")

          fill_in "pet_name", with: "Rex"
          click_button "Submit"

          click_on "Adopt this Pet"

          fill_in "description", with: "i want a dog"
          click_button "Submit Application"

          expect(current_path).to eq("/applicants/#{@bob.id}")

          expect(page).to_not have_content("Submit Application")
          expect(page).to_not have_content("Add a pet to this application")
          expect(page).to have_content("Pending")

        end

        it "Then I am taken back to the application's show page And I see an indicator that the application is 'Pending'" do
          visit "/applicants/#{@bob.id}"

          
        end
      end      
    end
  end
end