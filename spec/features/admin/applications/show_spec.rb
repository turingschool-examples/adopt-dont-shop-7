require "rails_helper"

RSpec.describe "Admin Application" do
    let! (:aurora) {aurora = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
    let! (:snoopy) {snoopy = Pet.create!(adoptable: true, age: 1, breed: "beagle", name: "Snoopy", shelter_id: aurora.id)}
    let! (:lobster) {lobster = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: aurora.id)}
    let! (:charlie) {charlie = Application.create!(applicant_name: "Charlie Brown", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Charlie has been looking forward to picking out a friend", application_status: "Pending")}
    let! (:join1) {ApplicationPet.create!(pet: snoopy, application: charlie)}
    let! (:join2) {ApplicationPet.create!(pet: lobster, application: charlie)}

    let! (:handsome) {handsome = Pet.create!(adoptable: true, age: 1, breed: "husky shepard", name: "Handsome", shelter_id: aurora.id)}
    let! (:jillybean) {jillybean = Pet.create!(adoptable: true, age: 3, breed: "english lab mix", name: "Jillybeen", shelter_id: aurora.id)}
    let! (:joop) {joop = Application.create!(applicant_name: "Joop", full_address: "123 Peanuts Rd, Lansing MI, 48864", description: "Really, really good looking", application_status: "Pending")}
    let! (:join3) {ApplicationPet.create!(pet: handsome, application: joop)}
    let! (:join4) {ApplicationPet.create!(pet: jillybean, application: joop)}
  describe "As a visitor" do
    it "can view admin application show page" do
      visit "/admin/applications/#{charlie.id}"

      expect(page).to have_content("Charlie Brown")
    end

    it "shows pets on application" do
      visit "/admin/applications/#{charlie.id}"

      expect(page).to have_content("Snoopy")
      expect(page).to have_content("Lobster")
      expect(page).to_not have_content("Handsome")
      expect(page).to_not have_content("Jillybean")
    end

    it "can approve application for specific dog" do
      visit "/admin/applications/#{charlie.id}"

      expect(page).to have_content("Snoopy")
      within("#pet-#{snoopy.id}") do
        click_button "Approved"
      end
    
      expect(page).to have_content("APPROVED")
    end
    
    it "can approve application for specific dog" do
      visit "/admin/applications/#{charlie.id}"
      
      expect(page).to have_content("Snoopy")
      within("#pet-#{snoopy.id}") do
        click_button "Rejected"
      end
      
      expect(page).to have_content("REJECTED")
    end
    
    it "can approve application for specific dog and not affect other applications" do
      ApplicationPet.create!(pet: snoopy, application: joop)
      visit "/admin/applications/#{joop.id}"

      expect(find("#pet-#{snoopy.id}")).to_not have_content("APPROVED")

      visit "/admin/applications/#{charlie.id}"

      expect(page).to have_content("Snoopy")
      within("#pet-#{snoopy.id}") do
        click_button "Approved"
      end
       
      expect(find("#pet-#{snoopy.id}")).to have_content("APPROVED")

      visit "/admin/applications/#{joop.id}"

      expect(find("#pet-#{snoopy.id}")).to_not have_content("APPROVED")
    end
  end
end