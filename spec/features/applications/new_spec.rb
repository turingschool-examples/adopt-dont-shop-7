require 'rails_helper'

RSpec.describe "new application" do
  describe 'application new page' do
    # User Story 2, Starting an Application
    it 'it will show a new application for the user to fill out' do
      application = Application.create(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "In Progress")
      
      visit '/applications/new'
      expect(page).to have_content("Name")
      expect(page).to have_content("Street address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip code")
      expect(page).to have_content("Why would you be a good home?")
      
      fill_in("Name", with: "Arthur")
      fill_in("Street address", with: "108 Clay St")
      fill_in("City", with: "Hialeah")
      select "Florida"
      fill_in("Zip code", with: "33010")
      fill_in(:description, with: "I would like a dog")
      click_button("Submit")
      
      expect(page).to have_content("Arthur")
      expect(page).to have_content("108 Clay St, Hialeah, FL 33010")
      expect(page).to have_content("I would like a dog")
      expect(page).to have_content("In Progress")
    end
    
    describe 'Sad Path Testing' do
      # User Story 3, Starting an Application, Form not Completed
      it 'will not let me submit form if fields not filled' do
        visit '/applications/new'

        fill_in("Name", with: "Arthur")
        fill_in("Street address", with: "108 Clay St")
        fill_in("City", with: "Hialeah")
        select "Florida"
        fill_in("Zip code", with: "33010")

        click_button("Submit")

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Error: Description can't be blank")
      end

      it 'will not let me submit form if zip code too short' do
        visit '/applications/new'

        fill_in("Name", with: "Arthur")
        fill_in("Street address", with: "108 Clay St")
        fill_in("City", with: "Hialeah")
        select "Florida"
        fill_in("Zip code", with: "3301")
        fill_in(:description, with: "I would like a dog")

        click_button("Submit")

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Error: Zip code is too short (minimum is 5 characters)")
      end

      it 'will not allow non-numerical zip codes' do
        visit '/applications/new'

        fill_in("Name", with: "Arthur")
        fill_in("Street address", with: "108 Clay St")
        fill_in("City", with: "Hialeah")
        select "Florida"
        fill_in("Zip code", with: "plane")
        fill_in(:description, with: "I would like a dog")

        click_button("Submit")

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Error: Zip code is not a number")
      end
    end
  end
end