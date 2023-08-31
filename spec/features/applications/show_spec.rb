require 'rails_helper'

RSpec.describe "Applications show", type: :feature do
  describe "As a visitor" do
    describe "When I visit an application's show page" do
      it "I can see the applicant's application data" do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille  Bald", shelter_id: shelter_1.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
        application_1 = Application.create(applicant_name: "Charlie Brown", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Charlie has been looking forward to picking out a friend", pet_id: pet_1.id, application_status: "Pending")
        visit "/application"

        expect(page).to have_content(application_1.applicant_name)
        expect(page).to have_content(application_1.full_address)
        expect(page).to have_content(application_1.description)
        expect(page).to have_content(application_1.pet)
        expect(page).to have_content(application_1.application_status)
      end
    end
  end
end
