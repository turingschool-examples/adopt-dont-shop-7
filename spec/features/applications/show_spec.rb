require "rails_helper"

RSpec.describe "the application show" do
  before :each do
    @shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @application = Application.create(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
  end

  describe "When I visit an applications show page"do 
    it "I can see the application attributes" do
      visit "/applications/#{@application.id}"
      save_and_open_page

      expect(page).to have_content(@application.name) 
      expect(page).to have_content(@application.street_address) 
      expect(page).to have_content(@application.city) 
      expect(page).to have_content(@application.state) 
      expect(page).to have_content(@application.zip_code) 
      expect(page).to have_content(@application.description) 
      expect(page).to have_content(@application.status) 
    end
  end
end
