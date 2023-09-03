require "rails_helper"

RSpec.describe "create applicant" do
  describe "As a visitor" do
    describe "When I visit the pet index page" do
      it "displays a link to 'Start an Application', which takes the user to the Create Applicant page" do
        visit "/pets"

        expect(page).to have_link("Start an Application")

        click_link "Start an Application"

        expect(current_path).to eq("/applicants/new")
      end
    end

    describe "When I click the 'Start an Application' link and visit the Create Applicant page" do
      it "displays a form to create a new Applicant" do
        visit "/applicants/new"

        expect(page).to have_content("New Applicant")
        fill_in 'Name', with: 'John Doe'
        fill_in 'Street address', with: '123 Main St'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip code', with: 80_202
        click_button "Submit Application"

        expect(current_path).to eq("/applicants/#{Applicant.last.id}")

        expect(page).to have_content('John Doe')
        expect(page).to have_content('123 Main St')
        expect(page).to have_content('Denver')
        expect(page).to have_content('CO')
        expect(page).to have_content(80_202)
        expect(page).to have_text('In Progress')
      end
    end
  end
end