require "rails_helper"

RSpec.describe "create applicant" do
  before(:each) do
    @bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")
    @greg = Applicant.create!(name: "Greg", street_address: "123 Street St", city: "Denver", state: "NC", zip_code: 00001, description: "I like petz", application_status: "In Progress")
  end

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
        fill_in "Name", with: "#{@greg.name}"
        fill_in "Street address", with: "#{@greg.street_address}"
        fill_in "City", with: "#{@greg.city}"
        fill_in "State", with: "#{@greg.state}"
        fill_in "Zip code", with: @greg.zip_code
        fill_in "Description", with: "#{@greg.description}"
        click_on "Submit Application"

        expect(current_path).to eq("/applicants/{#{@greg.id}}")

        expect(page).to have_content("#{@greg.name}")
        expect(page).to have_content("#{@greg.street_address}")
        expect(page).to have_content("#{@greg.city}")
        expect(page).to have_content("#{@greg.state}")
        expect(page).to have_content("#{@greg.zip_code}")
        expect(page).to have_content("#{@greg.description}")
        expect(page).to have_content("#{@greg.application_status}")
      end
    end
  end
end