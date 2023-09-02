require "rails_helper"

RSpec.describe "the admin index" do
  it "shows a list of shelters in reverse alphabetical order" do
    shelter_1 = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit "/admin/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_2.name)
    expect(shelter_3.name).to appear_before(shelter_1.name)
    expect(shelter_1.name).to appear_before(shelter_2.name)
  end
end

