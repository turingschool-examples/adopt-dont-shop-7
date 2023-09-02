require 'rails_helper'

RSpec.describe "Application Show Page" do
  describe "As a user" do
    describe "when I visit /applications/:id" do
      it "Shows all applicant info" do
        dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        application = PetsApplication.create!(applicant: dude, pet: pet_1)

        visit "/applications/#{application.id}"

        expect(page).to have_content("James")
        expect(page).to have_content("11234 Jane Street")
        expect(page).to have_content("Dallas")
        expect(page).to have_content("Texas")
        expect(page).to have_content("75248")
        expect(page).to have_content("I love animals!")
      end
    end

    it "I see links to all pets on this application" do
      dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
      state: "Texas", zip_code: "75248", description: "I love animals!")
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
      pet_2 = shelter.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe")
      application = PetsApplication.create!(applicant: dude, pet: pet_1)
      PetsApplication.create!(applicant: dude, pet: pet_2)

      visit "/applications/#{application.id}"

      expect(page).to have_link(href: "/pets/#{pet_1.id}")
      expect(page).to have_link(href: "/pets/#{pet_2.id}")
    end
  end
end