require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: "Greyhound Pets of America", city: "Parker, CO", foster_program: true, rank: 8)

    visit "admin/shelters"
  end

  it "lists all the shelter names" do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_4.name)
  end

  it "lists the shelters in reverse alphabetical order" do
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end
end
