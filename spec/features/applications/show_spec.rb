require "rails_helper"

RSpec.describe "Application 'show' Page", type: :feature do
  before(:each) do
    @application = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    @application_2 = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "EN", zip: "48J77", description: "I still believe love is all you need.  I don't know a better message than that.", status: "Pending")
    
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chiwawa", name: "Bamby", shelter_id: @shelter.id)

    @app_pet_1 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_1.id)
    @app_pet_2 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_2.id)
  end

  describe "As a visitor" do
    describe "When visiting an application show page" do
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

      describe "When the application has not been submitted" do
        it "Has a section that says 'Add a Pet to this Application'" do
          visit "/applications/#{@application.id}"
          
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Pet Search")

          visit "/applications/#{@application_2.id}"
          
          expect(page).to_not have_content("Add a Pet to this Application")
          expect(page).to_not have_field("Pet Search")
        end
        
        it "Redirects_to the application show page after filling in Pet's name" do
          visit "/applications/#{@application.id}"

          expect(page).to_not have_content(@pet_3.name)
          fill_in "Pet Search", with: "Ba"
          click_button "Search"

          expect(current_path).to eq("/applications/#{@application.id}")
          expect(page).to have_content(@pet_3.name)
        end
      end

      describe "Adopt this Pet" do
        it "has an 'Adopt this Pet' button next to each Pet name that links back to the application show page" do
          visit "/applications/#{@application.id}"
          
          expect(page).to_not have_content(@pet_3.name)
          fill_in "Pet Search", with: @pet_3.name
          click_button "Search"
          
          expect(page).to have_button("Adopt this Pet")
          click_button "Adopt this Pet"
      
          expect(page).to have_content(@pet_3.name)
          expect(current_path).to eq("/applications/#{@application.id}")
        end
      end
      # User Story 6: Submit an Applicaiton 
      # ====START TESTS====
      describe "and I have added one or more pets to the application" do
        it "then I see a section to submit my application" do
          # Make sure an in-progress application with pets DOES have the "application-submission" div element
          visit "/applications/#{@application.id}"
          expect(@application.pets).to_not be_empty
          expect(@application.status).to eq("In Progress")
          expect(page).to have_selector("#application_submission")
        end

        it "and I see an input in the submission section to enter why I would make a good owner for these pet(s)" do
          visit "/applications/#{@application.id}"

          within("#application_submission") do
            expect(page).to have_field(:description_owner, type: 
            "textarea")
            expect(page).to have_field(:status, type: :hidden)
          end
        end

        describe "When I fill in that input and click a button to submit the application" do
          before(:each) do
            visit "/applications/#{@application.id}"

            within("#application_submission") do
              fill_in "description_owner", with: "I would make a good owner because I am really, really, really good with dogs"
              click_button "Submit Application"
              @application.reload
            end            
          end

          it "then I am taken back to the application's show page" do
            expect(current_path).to eq ("/applications/#{@application.id}")
          end

          it "and I see indicator that the application is 'Pending'" do
            expect(@application.status).to eq("Pending")
            expect(page).to have_content("Status: Pending")
          end

          it "and I see all the pets that I want to adopt" do
            expect(page).to have_content(@pet_1.name)
            expect(page).to have_content(@pet_2.name)
          end

          it "and I do not see a section to add more pets to this application" do
            expect(page).to_not have_selector("#add-pets")
          end
        end
      end
      # ====END USER STORY 6 TESTS====

      # User Story 7: No Pets on an Application 
      # ====START TESTS====
      describe "and I have not added any pets to the application" do
        it "Then I do not see a section to submit my application" do
          petless = Application.create!(name: "Petless Tester", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I do not want any pets and have not added any to my application", status: "In Progress")

          # Make sure an in-progress application without pets DOES not have the "application-submission" div element
          visit "/applications/#{petless.id}"
          expect(petless.pets).to be_empty
          expect(petless.status).to eq("In Progress")
          expect(page).to_not have_selector("#application-submission")

          # #application-submission div shows up when you add a pet to the application
          app_pet_3 = ApplicationPet.create!(application_id: petless.id, pet_id: @pet_1.id)
          petless.reload
          visit "/applications/#{petless.id}"

          expect(petless.pets).to_not be_empty
          expect(page).to have_selector("#application_submission") 
        end       
      end
      # ====END USER STORY 7 TESTS====

    end
  end
end