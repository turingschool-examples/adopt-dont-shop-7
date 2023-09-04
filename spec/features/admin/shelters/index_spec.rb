require "rails_helper"

RSpec.describe "Admin Shelters Page" do
  it "can list all shelters by reverse alphabetical order" do
    broadway = Shelter.create!(foster_program: true, name: "Broadway", city: "Denver", rank: 7)
    englewood = Shelter.create!(foster_program: true, name: "Englewood", city: "Denver", rank: 7)
    colemine = Shelter.create!(foster_program: true, name: "Colemine", city: "Denver", rank: 7)
    arapahoe = Shelter.create!(foster_program: true, name: "Arapahoe", city: "Denver", rank: 7)
    denver = Shelter.create!(foster_program: true, name: "Denver", city: "Denver", rank: 7)

    visit "/admin/shelters"

    expect("Englewood").to appear_before("Denver")
    expect("Denver").to appear_before("Colemine")
    expect("Colemine").to appear_before("Broadway")
    expect("Broadway").to appear_before("Arapahoe")
  end
end