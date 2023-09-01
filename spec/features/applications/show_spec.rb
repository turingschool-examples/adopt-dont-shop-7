require 'rails_helper'

RSpec.describe "Applications show", type: :feature do
  describe "As a visitor" do
    describe "When I visit an application's show page" do
      it "I can see the applicant's application data" do
        shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille  Bald", shelter_id: shelter_1.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)
        application_1 = Application.create(applicant_name: "Charlie Brown", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Charlie has been looking forward to picking out a friend", application_status: "Pending")
        ApplicationPet.create(pet: pet_1, application: application_1)
        ApplicationPet.create(pet: pet_2, application: application_1)
        visit "/applications/#{application_1.id}"
        save_and_open_page

        expect(page).to have_content("Charlie Brown")
        expect(page).to have_content("123 Peanuts Rd, Lansing MI, 48864")
        expect(page).to have_content("Charlie has been looking forward to picking out a friend")
        expect(page).to have_content("Lucille Bald")
        expect(page).to have_content("Pending")
      end
    end
  end
end
