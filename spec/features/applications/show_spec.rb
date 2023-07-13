require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before(:each) do
    @application = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
  end

  describe "as a visitor" do
    describe "when visiting applicaiton show page" do
      it "I can see applicant details" do
        
        visit "/applications/#{@application.id}"

        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.street)
        expect(page).to have_content(@application.city)
        expect(page).to have_content(@application.state)
        expect(page).to have_content(@application.zip)
        expect(page).to have_content(@application.description)
        expect(page).to have_content(@application.status)
      end

      it "I can see the names of all pets this application is for with links to their show page"

      it "show the applications status to be either 'In Progress', 'Pending', 'Accepted', or 'Rejected'"
    end
  end
end