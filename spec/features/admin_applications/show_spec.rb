require "rails_helper"

RSpec.describe "admin applications show page" do
  before(:each) do
    @app1 = Application.create!(
      name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
      description: "Good home for good boy", status: "In Progress"
    )
    @app2 = Application.create!(
      name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "In Progress"
    )
    @app_accepted = Application.create!(
      name: "Robby", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "Accepted"
    )
    @s1 = Shelter.create!(foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2)
    @p1 = Pet.create!(name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id)
    @p2 = Pet.create!(name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id)
    PetApplication.create!(application: @app1, pet: @p2)
    PetApplication.create!(application: @app2, pet: @p1)
  end

  it "allows admin to approve pet on application" do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
    visit "/admin/applications/#{@app2.id}"

    within("#pet-#{@p1.id}") do
      click_button "Approve"
    end

    within("#pet-#{@p1.id}") do
      have_no_button "Approve"
      have_content "Approved"
    end
  end
end
