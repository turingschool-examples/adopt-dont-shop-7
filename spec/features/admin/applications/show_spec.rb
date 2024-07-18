require "rails_helper"

RSpec.describe "the applications show" do

  before :each do
    @shelter1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @shelter2 = Shelter.create!(name: "Fuzzy Paws", city: "Boulder CO", foster_program: false, rank: 4)
    @shelter3 = Shelter.create!(name: "Good Boys", city: "New York NY", foster_program: true, rank: 2)
    @shelter4 = Shelter.create!(name: "Roshar Creatures", city: "Whimsical", foster_program: false, rank: 1)

    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Dozer", age: 6, breed: "Pitbull", adoptable: true, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Gunther", age: 10, breed: "Rottweiler", adoptable: true, shelter_id: @shelter3.id)
    @pet4 = Pet.create!(name: "Carl", age: 7, breed: "Goat", adoptable: false, shelter_id: @shelter4.id)

    @application1 = Application.create!(name: "Joe Baeza", street_address: "12345 Joe Street", city: "Irvine", state: "CA", zip_code: "54321",
                                        description: "I like Scooby and Carl so I want to adopt them", status: "In Progress")
    @application2 = Application.create!(name: "Billy Bob", street_address: "56789 The Bob Street", city: "Boulder", state: "CO", zip_code: "09876",
                                        description: "Dozer looks badass and I am a guy who wants a badass dog.", status: "In Progress")
    @application3 = Application.create!(name: "The Guy", street_address: "111111 The Guy Avenue", city: "Seattle", state: "WA", zip_code: "29212",
                                        description: "I am the guy. The guy deserves a pet, don't you think?", status: "In Progress")

    @pet_application1 = PetApplication.create!(application: @application1, pet: @pet1, pet_app_status: "Pending")
    @pet_application2 = PetApplication.create!(application: @application2, pet: @pet2, pet_app_status: "Pending")
    @pet_application3 = PetApplication.create!(application: @application2, pet: @pet4)
  end

  describe "As a visitor do" do
    describe "when I visit an admin applications show page" do 
      it "displays the sort of view to the user" do
        visit "/admin/applications/#{@application2.id}"
        expect(page).to have_content("This is the Admin view")
      end

      it "will display the pets that correspond to this application with buttons to accept or reject the pet that dissapear after the pet has been rejected" do
        visit "admin/applications/#{@application2.id}"

        expect(page).to have_content("#{@application2.id} Show Page")

        within ("#pet-application-#{@pet_application2.id}-#{@pet_application2.pet.id}") do
          expect(page).to have_content("#{@pet2.name}")
          expect(page).to have_content("Accept Pet")
          expect(page).to have_content("Reject Pet")

          click_button "Accept Pet"

          expect(page).to_not have_content("Accept Pet")
          expect(page).to_not have_content("Reject Pet")

          expect(page).to have_content("#{@pet_application2.pet.name} Accepted")
        end 

        within ("#pet-application-#{@pet_application3.id}-#{@pet_application3.pet.id}")
          expect(page).to have_content("#{@pet4.name}")
          expect(page).to have_content("Accept Pet")
          expect(page).to have_content("Reject Pet")

          click_button "Reject Pet"

          expect(page).to_not have_content("Accept Pet")
          expect(page).to_not have_content("Reject Pet")

          expect(page).to have_content("#{@pet_application3.pet.name} Rejected")
        end

      end
    end
  end