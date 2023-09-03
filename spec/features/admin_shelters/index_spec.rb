require "rails_helper"

RSpec.describe "the pets index" do
  it "Lists shelters in decending order" do
    shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Ford shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Zeta shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    visit '/admin/shelters'

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    # this = team_7.created_at.to_s
    # that = team_4.created_at.to_s
    expect(shelter_3.name).to appear_before(shelter_1.name)
  end
end