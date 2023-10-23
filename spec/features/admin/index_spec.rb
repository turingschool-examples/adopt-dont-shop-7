require "rails_helper"

RSpec.describe "admin shelter index" do
  it "lists all the shelters in the system in reverse alphabetical order" do
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: true, rank: 10)
    shelter3 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 8)

    visit "/admin/shelters"

    # Then I see all Shelters in the system listed in reverse alphabetical order by name
save_and_open_page
    expect("Denver shelter").to appear_before("Boulder shelter")
    expect("Boulder shelter").to appear_before("Aurora shelter")
  end
end
