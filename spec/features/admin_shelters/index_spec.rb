require "rails_helper"

RSpec.describe "the shelters index" do
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
    PetApplication.create!(application: @app5, pet: @s1_p2)
  end

  it "lists all the shelter names in reverse order" do
    # US 10
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    visit "admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it "displays a section for every shelter with a pending applciation" do
    # US 11
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelters with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application

    visit "/admin/shelters"

    within "#shelters_pending_applications" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_4.name)
      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end
end
