require 'rails_helper'

RSpec.describe "Application Show Page" do 
    before(:each) do
        @sunnyside = Shelter.create!(name: "Sunnyside", foster_program: false, city: "Boulder", rank: 2)
        @fluffy = @sunnyside.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "Sphynx")
        @copper = @sunnyside.pets.create!(name: "Copper", adoptable: false, age: 5, breed: "German Shephard")
        @willow = @sunnyside.pets.create!(name: "Willow", adoptable: true, age: 1, breed: "Labrador")
        @applicant_1 = @fluffy.applications.create!(name: "Phylis", street_address: "1234 main circle", city: "Littleton", state: "CO", zipcode: "80241", reason_for_adoption: "I have a huge yard", status: "In Progress")
            # fluffy.petapplications?
            # pet.petapplications.create(status)
            # 
    end

    it "show information for the applicant" do
        visit "/applications/#{@applicant_1.id}"
        expect(page).to have_content("Phylis")
        expect(page).to have_content("1234 main circle")
        expect(page).to have_content("Littleton")
        expect(page).to have_content("CO")
        expect(page).to have_content("80241")
        expect(page).to have_content("I have a huge yard")
        expect(page).to have_content("In Progress")
    end

    it "has names of all pets and links to their show page" do
        visit "/applications/#{@applicant_1.id}"
        expect(page).to have_link("Copper", href: "/pets/#{@copper.id}")
        expect(page).to have_link("Willow", href: "/pets/#{@willow.id}")

    end
end