require "rails_helper"

RSpec.describe "the adoption application index page" do

    # User Story 2
    # As a visitor
    # When I visit the pet index page
    # Then I see a link to "Start an Application"
    describe "new application link" do
        it "has a link to start an application" do
            visit "/applications"

            expect(page).to have_link("Start an Application", href: "/applications/create")
        end

        it "redirects to adoption application create page" do
            visit "/applications"

            click_link("Start an Application")

            expect(current_path).to eq("/applications/create")
        end
    end
end