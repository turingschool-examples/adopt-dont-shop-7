require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  end

  describe "User Story 10: Admin Shelters Index" do
    describe "In the admin shelter index, I see all Shelters in the system listed in reverse alphabetical order by name" do

      it "lists shelters in reverse alphabetical order" do
        visit "/admin/shelters"

        first = find("#shelter-#{@shelter_2.id}")
        middle = find("#shelter-#{@shelter_3.id}")
        last = find("#shelter-#{@shelter_1.id}")

        expect(first).to appear_before(middle)
        expect(middle).to appear_before(last)

        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content("Created at: #{@shelter_1.created_at}")
          expect(page).to have_link("Update #{@shelter_1.name}")
          expect(page).to have_link("Delete #{@shelter_1.name}")
        end

        within "#shelter-#{@shelter_2.id}" do
          expect(page).to have_content("Created at: #{@shelter_2.created_at}")
          expect(page).to have_link("Update #{@shelter_2.name}")
          expect(page).to have_link("Delete #{@shelter_2.name}")
        end

        within "#shelter-#{@shelter_3.id}" do
          expect(page).to have_content("Created at: #{@shelter_3.created_at}")
          expect(page).to have_link("Update #{@shelter_3.name}")
          expect(page).to have_link("Delete #{@shelter_3.name}")
        end
      end
    end
  end

end