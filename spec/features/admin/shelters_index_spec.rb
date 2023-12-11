require "rails_helper"

RSpec.describe "the admin shelter index", type: :feature do

  it 'lists all shelters in reverse alphabetical order' do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    visit "/admin/shelters"

    expect(page.body.index("RGV animal shelter")).to be < page.body.index("Aurora shelter")
    expect(page.body.index("RGV animal shelter")).to_not be > page.body.index("Aurora shelter")
  end
end
