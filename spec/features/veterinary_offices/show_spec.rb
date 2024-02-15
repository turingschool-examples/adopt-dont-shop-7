require "rails_helper"

RSpec.describe "the vet office show" do
  let!(:vet_office) {VeterinaryOffice.create!(name: "The Country Vet", boarding_services: true, max_patient_capacity: 200)}
  
  before do
    visit "/veterinary_offices/#{vet_office.id}"
  end

  it "shows the vet office and all it's attributes" do
    expect(page).to have_content(vet_office.name)
    expect(page).to have_content(vet_office.max_patient_capacity)
  end

  it "shows the number of veterinarians associated with the vet office" do
    within ".veterinarian-count" do
      expect(page).to have_content(vet_office.veterinarians.count)
    end
  end

  it "allows the user to delete a vet office" do
    click_on("Delete #{vet_office.name}")

    expect(page).to have_current_path("/veterinary_offices")
    expect(page).to_not have_content(vet_office.name)
  end

  it "displays a link to the veterinary offices's veterinarians" do
    expect(page).to have_link("All veterinarians at #{vet_office.name}")
    
    click_link("All veterinarians at #{vet_office.name}")

    expect(page).to have_current_path("/veterinary_offices/#{vet_office.id}/veterinarians")
  end
end
