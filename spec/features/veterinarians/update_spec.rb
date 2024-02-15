require "rails_helper"

RSpec.describe "the veterinarian update" do
  let!(:vet_office) {VeterinaryOffice.create!(name: "Put a bird on it", boarding_services: true, max_patient_capacity: 5)}
  let!(:vet) {vet_office.veterinarians.create!(name: "Kelsey", on_call: true, review_rating: 9)}

  before do
    visit "/veterinarians/#{vet.id}/edit"
  end

  it "shows the veterinarian edit form" do
    expect(find("form")).to have_content("Name")
    expect(find("form")).to have_content("Review rating")
    expect(find("form")).to have_content("On call")
  end

  context "given valid data" do
    it "submits the edit form and updates the veterinarian" do
      fill_in "Name", with: "Ignacio"
      uncheck "On call"
      fill_in "Review rating", with: 10
      click_button "Save"

      expect(page).to have_current_path("/veterinarians/#{vet.id}")
      expect(page).to have_content("Ignacio")
      expect(page).to_not have_content("Kelsey")
    end
  end

  context "given invalid data" do
    it "re-renders the edit form" do
      fill_in "Name", with: ""
      click_button "Save"

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/veterinarians/#{vet.id}/edit")
    end
  end
end
