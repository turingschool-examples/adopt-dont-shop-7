require "rails_helper"

RSpec.describe "application creation" do
  describe "new applicant" do
    it "renders the new applicant form" do

    visit "/applicants/new"

    expect(page).to have_content("New Pet")
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Breed")
    expect(find("form")).to have_content("Age")
    expect(find("form")).to have_content("Adoptable")
    end
  end
  describe "the application form" do
    it "fills out the form and is redirected to the show page" do

      visit "/applicants/new"

      fill_in "Name", with: "James"
      fill_in "Street Address", with: "11234 Jane Street"
      fill_in "City", with: "Dallas"
      fill_in "State", with: "Texas"
      fill_in "Zip Code", with: "75248"
      fill_in "Description", with: "I love animals!"
      click_button "Submit"
      # expect(page).to have_current_path("/applicants/#{@shelter.id}/pets")
      expect(page).to have_content("James")
      expect(page).to have_content("11234 Jane Street")
      expect(page).to have_content("Dallas")
      expect(page).to have_content("Texas")
      expect(page).to have_content("75248")
      expect(page).to have_content("I love animals!")
    end
  end
end