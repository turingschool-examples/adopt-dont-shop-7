require "rails_helper"

RSpec.describe "admin shelter index" do
  before :each do
    @shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter3 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 8)
    @app1 = App.create(name: "Timmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love dogs")
    @pet2 = @shelter1.pets.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
    @pet3 = @shelter2.pets.create(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")
  end
  
  it "has a shelters with pending applications section" do
    @app1.pets << @pet3
    @app1.pets << @pet2

    visit "/admin/shelters"

    within("#pending") do
      expect(page).to have_content("Denver shelter")
      expect(page).to have_content("Aurora shelter")
    end

  end

  it "lists all the shelters in the system in reverse alphabetical order" do
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')

    visit "/admin/shelters"

    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    expect("Denver shelter").to appear_before("Boulder shelter")
    expect("Boulder shelter").to appear_before("Aurora shelter")
  end
end
