require 'rails_helper'

RSpec.describe "Application Show Page" do
  describe "As a user" do
    describe "when I visit /application/:id" do
      it "Shows all applicant info" do
        dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")

        visit "/applications/#{dude.id}"

        expect(page).to have_content("James")
        expect(page).to have_content("11234 Jane Street")
        expect(page).to have_content("Dallas")
        expect(page).to have_content("Texas")
        expect(page).to have_content("75248")
        expect(page).to have_content("I love animals!")
      end
    end
  end
end