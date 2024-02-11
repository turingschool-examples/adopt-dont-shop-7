require 'rails_helper'

RSpec.describe "Admin Shelters Index Page" do
  let!(:shelter_1) {Shelter.create!(foster_program: true, name: "Adopters Unite", city: "Minneapolis", rank: 1 ) }
  let!(:shelter_2) {Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
  let!(:shelter_3) {Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)}

  before do
    visit "/admin/shelters"
  end

  describe "As a Visitor" do
    describe "User Story 10" do
      it "lists all shelters names in reverse alphabetical order" do
        expect(shelter_3.name).to appear_before(shelter_2)
        expect(shelter_2.name).to appear_before(shelter_1)
      end
    end
  end
end