require "rails_helper"

RSpec.describe "application creation" do
  describe "new applicant" do
    it "renders the new applicant form" do

    visit "/applications/new"

    expect(page).to have_content("New Adoption Application")
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Street Address")
    expect(find("form")).to have_content("City")
    expect(find("form")).to have_content("State")
    expect(find("form")).to have_content("Zip Code")
    expect(find("form")).to have_content("Description")
    end
  end
  describe "the application form" do
    it "fills out the form and is redirected to the show page" do

      visit "/applications/new"

      fill_in "Name", with: "James"
      fill_in "Street Address", with: "11234 Jane Street"
      fill_in "City", with: "Dallas"
      fill_in "State", with: "Texas"
      fill_in "Zip Code", with: "75248"
      fill_in "Description", with: "I love animals!"
      click_button "Submit Application"
      # expect(page).to have_current_path("/applicants/#{@applicant.id}")
      expect(page).to have_content("James")
      expect(page).to have_content("11234 Jane Street")
      expect(page).to have_content("Dallas")
      expect(page).to have_content("Texas")
      expect(page).to have_content("75248")
      expect(page).to have_content("I love animals!")
    end
  end

  describe "the application form" do
    it "if part of the application does not have an input, an error message will display" do

      visit "/applications/new"

      fill_in "Name", with: "James"
      fill_in "Street Address", with: "11234 Jane Street"
      fill_in "State", with: "Texas"
      fill_in "Description", with: "I love animals!"
      click_button "Submit Application"

      expect(page).to have_content("Error: City can't be blank, Zip code can't be blank")
      click_button "Submit Application"
      expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")


      
    end
  end
end