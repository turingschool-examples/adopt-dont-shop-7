require "rails_helper"

RSpec.describe "Admin Application" do
    let (:aurora) {aurora = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
    let (:snoopy) {snoopy = Pet.create!(adoptable: true, age: 1, breed: "beagle", name: "Snoopy", shelter_id: aurora.id)}
    let (:lobster) {lobster = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: aurora.id)}
    let (:charlie) {charlie = Application.create!(applicant_name: "Charlie Brown", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Charlie has been looking forward to picking out a friend", application_status: "Pending")}
    let (:join1) {ApplicationPet.create!(pet: snoopy, application: charlie)}
    let (:join2) {ApplicationPet.create!(pet: pet_2, application: charlie)}
  describe "As a visitor" do
    it "can view admin application show page" do
      visit "/admin/applications/#{charlie.id}"

      expect(page).to have_content("Charlie Brown")
    end
  end
end