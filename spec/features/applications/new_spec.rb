require "rails_helper"

RSpec.describe "applications new page" do
  before(:each) do
    @app1 = Application.create!(name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
      description: "Good home for good boy", status: "In Progress")
    @app2 = Application.create!(name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "In Progress")
    @s1 = Shelter.create!(foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2)
    @p1 = Pet.create!(name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id)
    @p2 = Pet.create!(name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id)
    PetApplication.create!(application: @app1, pet: @p2)
    PetApplication.create!(application: @app2, pet: @p1)
  end

  it "handles invalid input in the new form field" do
    # As a visitor
    # When I visit the new application page
    # And I fail to fill in any of the form fields
    # And I click submit
    # Then I am taken back to the new applications page
    # And I see a message that I must fill in those fields.

    visit "/applications/#{@app1.id}/new"

    fill "Name", with: "Sir TP"

    click_button "Submit"
    
    expect(page).to have_content "You must fill in each field"
  end
end
