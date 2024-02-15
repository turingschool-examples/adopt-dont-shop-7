require "rails_helper"

RSpec.describe "the vet office update" do
  let!(:vet_office) {VeterinaryOffice.create!(name: "Aurora vet office", boarding_services: false, max_patient_capacity: 9)}
  
  before do
    visit "/veterinary_offices/#{vet_office.id}/edit"
  end

  it "shows the vet office edit form" do
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Max patient capacity")
    expect(find("form")).to have_content("Boarding services")
  end

  describe "given valid data" do
    it "submits the edit form and updates the vet office" do
      fill_in "Name", with: "Wichita vet office"
      uncheck "Boarding services"
      fill_in "Max patient capacity", with: 10
      click_button "Save"

      expect(page).to have_current_path("/veterinary_offices")
      expect(page).to have_content("Wichita vet office")
      expect(page).to_not have_content("Houston vet office")
    end
  end

  describe "given invalid data" do
    it "re-renders the edit form" do
      fill_in "Name", with: ""
      click_button "Save"

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/veterinary_offices/#{vet_office.id}/edit")
    end
  end
end
