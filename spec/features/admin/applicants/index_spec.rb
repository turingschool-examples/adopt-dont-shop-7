require 'rails_helper'

RSpec.describe 'the admin/applicants' do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "I like petz", application_status: "Pending")
    @shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter1.id)
    ApplicantsPet.create!(applicant: @bob, pet: @pet_1)
  end

  describe "As a visitor" do
    describe "When I visit the admin applicants index page" do
      it "displays all applicants who have applications submitted and their attributes" do
        visit "/admin/applications"

        expect(page).to have_link("Applicants Show page")
        expect(page).to have_content("#{@bob.name}")
        expect(page).to have_content("Address:")
        expect(page).to have_content("#{@bob.street_address}")
        expect(page).to have_content("#{@bob.city}")
        expect(page).to have_content("#{@bob.zip_code}")
        expect(page).to have_content("Why I would make a good home:")
        expect(page).to have_content("#{@bob.description}")
        expect(page).to have_content("Application Status:")
        expect(page).to have_content("#{@bob.application_status}")
      end

      describe "And I click the link 'Applicants Show page'" do
        it "takes me to the Admin Applicants Show page" do
          visit "/admin/applications"

          click_on "Applicants Show page"

          expect(current_path).to eq("/admin/applications/#{@bob.id}")
        end
      end
    end
  end
end