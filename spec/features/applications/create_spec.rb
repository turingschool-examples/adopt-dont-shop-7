require "rails_helper"

RSpec.describe "Application Creation" do

    it "has link from the pet index page" do
        visit "/pets"

        expect(page).to have_link("Start an Application", href: "/applications/new")
    end

    it "has a form to create an application" do
        visit "/pets" 

        click_link("Start an Application")

        expect(page).to have_field(:name)
        expect(page).to have_field(:street_address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip_code)
        expect(page).to have_field(:reason_for_adoption)
        expect(page).to have_button("Submit")
    end

    it "can create a application and redirect to applicant show page" do
        visit "/applications/new"

        fill_in(:name, with: "Roger")
        fill_in(:street_address, with: "6767 Running Ln")
        fill_in(:city, with: "Boulder")
        fill_in(:state, with: "CO")
        fill_in(:zip_code, with: "80233")
        fill_in(:reason_for_adoption, with: "because")
        click_button("Submit")

        app = Application.last

        expect(current_path).to eq("/applications/#{app.id}")
        expect(page).to have_content("Roger")
        expect(page).to have_content("6767 Running Ln")
        expect(page).to have_content("Boulder")
        expect(page).to have_content("CO")
        expect(page).to have_content("80233")
        expect(page).to have_content("because")
        expect(page).to have_content("In Progress")
    end

    it "should show an error if user does not fill out name" do
        visit "/applications/new"

        fill_in(:street_address, with: "369 Fine Ln")
        fill_in(:city, with: "Lowdown City")
        fill_in(:state, with: "NY")
        fill_in(:zip_code, with: "35461")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: Name can't be blank")
    end

    it "should show an error if user does not fill out address" do
        visit "/applications/new"

        fill_in(:name, with: "Levi")
        fill_in(:city, with: "Denim")
        fill_in(:state, with: "CA")
        fill_in(:zip_code, with: "98765")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: Street address can't be blank")
    end

    it "should show an error if user does not fill out city" do 
        visit "/applications/new"

        fill_in(:name, with: "Billy")
        fill_in(:street_address, with: "The Dream Palace")
        fill_in(:state, with: "FL")
        fill_in(:zip_code, with: "98765")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: City can't be blank")
    end

    it "should show an error if user does not fill out state" do 
        visit "/applications/new"

        fill_in(:name, with: "Billy")
        fill_in(:street_address, with: "The Dream Palace")
        fill_in(:city, with: "Rainbow Road")
        fill_in(:zip_code, with: "98765")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: State can't be blank")
    end

    it "should show an error if user does not fill out zip code" do
        visit "/applications/new"

        fill_in(:name, with: "Billy")
        fill_in(:street_address, with: "The Dream Palace")
        fill_in(:city, with: "Rainbow Road")
        fill_in(:state, with: "FL")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: Zip code can't be blank")
    end

    it "should show error if user misses a few required fields" do
        visit "/applications/new"

        fill_in(:name, with: "Billy")
        fill_in(:city, with: "Rainbow Road")
        click_button("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: Street address can't be blank, State can't be blank, Zip code can't be blank")
    end
end