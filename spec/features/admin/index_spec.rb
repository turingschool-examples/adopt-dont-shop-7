require "rails_helper"

RSpec.describe "Admin Shelter Index",type: :feature do
  describe "as a visitor" do
    describe "when I visit the admin shelter index ('/admin/shelters/)" do
      it "I see all shelters in the system listed in reverse alphabetical order by name" do
        shelter_1 = Shelter.create!(
          foster_program: true,
          name: "The Shelter",
          city: "Happy City",
          rank: 1
        )
        shelter_2 = Shelter.create!(
          foster_program: true,
          name: "City Shelter",
          city: "Sad City",
          rank: 1
        )
        shelter_2 = Shelter.create!(
          foster_program: true,
          name: "Zoo Shelter",
          city: "Zoo City",
          rank: 1
        )
        
        visit "/admin/shelters"

        expect(page).to have_content("The Shelter")
        expect(page).to have_content("City Shelter")
        expect(page).to have_content("Zoo Shelter")

        expect("Zoo Shelter").to appear_before("The Shelter")
        expect("The Shelter").to appear_before("City Shelter")
      end
    end
  end
end