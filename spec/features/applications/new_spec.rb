require "rails_helper"

RSpec.describe "new application form" do
  describe "as a visitor" do
    describe "when I visit the new application form" do
      # User Story 2
      # am taken to the new application page where I see a form When I fill in this form with my:

      # Name
      # Street Address
      # City
      # State
      # Zip Code
      # Description of why I would make a good home And I click submit Then I am taken to the new
      # application's show page And I see my Name, address information, and description of why I
      # would make a good home And I see an indicator that this application is "In Progress"

      it "has a form with attributes" do
        visit "/applications/new"
        fill_in("Name", with: "Joey")
        fill_in("Street Address", with: "32 Shifty")
        fill_in("City", with: "Englewood")
        fill_in("State", with: "ME")
        fill_in("Zip Code", with: "01234")
        fill_in("Why I would be a good pet owner:", with: "I AM JOEY")
        click_button "Submit Application"

        expect(current_path).to eq("/applications/#{Application.all.first.id}")
        expect(page).to have_content(Application.all.first.name)
        expect(page).to have_content(Application.all.first.address)
        expect(page).to have_content(Application.all.first.city)
        expect(page).to have_content(Application.all.first.state)
        expect(page).to have_content(Application.all.first.zip_code)
        expect(page).to have_content(Application.all.first.description)

        Application.all.first.update(status: "In Progress")
        visit "/applications/#{Application.all.first.id}"
        expect(page).to have_content(Application.all.first.status)
      end
    end

    #user story 3 
    describe "Failure to fill in form fields" do 
      it 'redirects back to new application page' do 
        visit "/applications/new"
        fill_in("Name", with: "Ricky")
        click_button "Submit Application"
        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Please Fill Out Entire Form")
      end
    end
  end
end