require "rails_helper"

RSpec.describe "admin applications show page" do
  before(:each) do
    # Shelters
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: "Small Paws Rescue", city: "Boulder, CO", foster_program: true, rank: 7)

    # Pets
    @s1_p1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @s1_p2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @s3_p1 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @s4_p1 = @shelter_4.pets.create(name: "Whiskers", breed: "siamese", age: 2, adoptable: true)

    # Applications
    @app1 = Application.create!({name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
                              description: "Good home for good boy", status: "In Progress"})
    @app2 = Application.create!({name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
                              description: "Good home for good boy", status: "Pending"})
    @app3 = Application.create!({name: "Alice", address: "456 N Lincoln", city: "Aurora", state: "CO", zip: "80203",
                              description: "I love cats", status: "Accepted"})
    @app4 = Application.create!({name: "Bob", address: "789 W Colfax", city: "Denver", state: "CO", zip: "80204",
                              description: "Dogs are my favorite", status: "Pending"})
    @app5 = Application.create!({name: "Eve", address: "111 E 3rd Ave", city: "Denver", state: "CO", zip: "80205",
                              description: "Looking for a buddy", status: "Pending"})

    # Pet-Application links
    PetApplication.create!(application: @app1, pet: @s1_p2)
    PetApplication.create!(application: @app2, pet: @s1_p1)
    PetApplication.create!(application: @app3, pet: @s3_p1)
    PetApplication.create!(application: @app4, pet: @s4_p1)
    PetApplication.create!(application: @app5, pet: @s3_p1)
  end

  it "allows admin to approve pet on application" do
    # US 12
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
    visit "/admin/applications/#{@app2.id}"

    within("#pet-#{@s1_p1.id}") do
      click_button "Approve"
    end

    expect(current_path).to eq "/admin/applications/#{@app2.id}"

    within("#pet-#{@s1_p1.id}") do
      have_no_button "Approve"
      have_content "Approved"
    end
  end

  # US 13
  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to reject the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I rejected, I do not see a button to approve or reject this pet
  # And instead I see an indicator next to the pet that they have been rejected
  it "displays a button to reject the application for a specific pet" do
    visit "/admin/applications/#{@app2.id}"

    within("#pet-#{@s1_p1.id}") do
      click_button "Reject"
    end

    expect(current_path).to eq("/admin/applications/#{@app2.id}")

    within("#pet-#{@s1_p1.id}") do
      # expect(page).to have_no_button("Reject")
      expect(page).to have_content("Rejected ❌")
    end
  end


  # US 14
  # As a visitor
  # When there are two applications in the system for the same pet
  # When I visit the admin application show page for one of the applications
  # And I approve or reject the pet for that application
  # When I visit the other application's admin show page
  # Then I do not see that the pet has been accepted or rejected for that application
  # And instead I see buttons to approve or reject the pet for this specific application
  it "approved/rejected pets on one application do not affect other applications" do
    visit "/admin/applications/#{@app3.id}"

    click_button("Approve")

    within("#pet-#{@s3_p1.id}") do
      expect(page).to have_content("Approved")
    end

    visit "/admin/applications/#{@app5.id}"

    within("#pet-#{@s3_p1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end
