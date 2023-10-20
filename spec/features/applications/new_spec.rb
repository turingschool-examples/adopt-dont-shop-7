require "rails_helper"

RSpec.describe "New Application Form", type: :feature do
  before :each do
    @app1 = Application.create!({name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102", description: "Good home for good boy", status: "In Progress"})
    @app2 = Application.create!({name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132", description: "Good home for good boy", status: "In Progress"})
    @s1 = Shelter.create!({foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2})
    @p1 = Pet.create!({name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id})
    @p2 = Pet.create!({name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id})
    PetApplication.create!(application: @app1, pet: @p2)
    PetApplication.create!(application: @app2, pet: @p1)
  end

  # US 2 Part 2
  describe "As a visitor" do
    describe "when I visit /applications index page" do
      it "displays a form to create a new application" do
        # As a visitor
        # When I visit the pet index page
        # Then I see a link to "Start an Application"
        # When I click this link
        # Then I am taken to the new application page where I see a form
        # When I fill in this form with my:
        #   - Name
        #   - Street Address
        #   - City
        #   - State
        #   - Zip Code
        #   - Description of why I would make a good home
        # And I click submit
        # Then I am taken to the new application's show page
        # And I see my Name, address information, and description of why I would make a good home
        # And I see an indicator that this application is "In Progress"

        visit "/applications/new" 

        fill_in "Name", with: "Roman"
        fill_in "Street Address", with: "444 Berry Way"
        fill_in "City", with: "Boulder"
        fill_in "State", with: "CO"
        fill_in "Zip Code", with: "88888"
        fill_in "Description of why I would make a good home", with: "A loving family."
        fill_in "Status"
        click_button "Submit"

        expect(current_path).to_not eq("/applications/new")
        # expect(current_path).to eq("/applications/#{application.id}")

        expect(page).to have_content("Roman")
        expect(page).to have_content("444 Berry Way")
        expect(page).to have_content("A loving family")
        expect(page).to have_content("In Progress")
      end
    end
  end
end