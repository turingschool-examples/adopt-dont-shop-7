require "rails_helper"

RSpec.describe "Admin Shelter Index page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "Mystery Building", city: "Irvine, CA", foster_program: false, rank: 9)
    @shelter_3 = Shelter.create!(name: "Dumb Friends League", city: "Denver, CO", foster_program: true, rank: 10)
  end

  describe "As a visitor" do
    describe "When I visit the admin shelter index ('/admin/shelters')" do
      it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
        visit "/admin/shelters"

        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_3.name)

        expect(@shelter_1.name).to appear_before(@shelter_2.name)
        expect(@shelter_1.name).to appear_before(@shelter_3.name)

        expect(@shelter_3.name).to appear_before(@shelter_2.name)
      end
    end
  end

end