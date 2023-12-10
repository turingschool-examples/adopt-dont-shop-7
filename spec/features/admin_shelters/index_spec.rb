require "rails_helper"

RSpec.describe "the application show" do
  it "displays all shelters in the system in reverse alphabetical order" do
    shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora Co", foster_program: false, rank: 3)
    shelter_2 = Shelter.create!(name: "Denver shelter", city: "Denver, CO", foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 9)
    # 10. Admin Shelters Index
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    visit "admin/shelters"
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    expect("Denver shelter").to appear_before("Boulder shelter")
    expect("Boulder shelter").to appear_before("Aurora shelter")
  end
end