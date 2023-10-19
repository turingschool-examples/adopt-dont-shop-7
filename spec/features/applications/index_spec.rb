require "rails_helper"

RSpec.describe Applications do

  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
  end

  describe 'Starting an Application' do
    it 'has a link on pet index page' do
      visit "/pets"
      
      expect(page).to have_link "Start an Application", href: "/applications/new"
    end

    it "On this page I see a form" do
      visit "/applications/new"

      
      fill_in('Name', with: 'Biggie')
      fill_in('Street Address', with: 'South State Street')
      fill_in('City', with: 'Salt Lake City')
      fill_in('State', with: 'UT')
      fill_in('Zip Code', with: '84105')
      fill_in('Description', with: 'Why would you be a good pet parent?')
      
      expect(page).to have_button "Submit", href: "/applications/show"
      click_button('Submit')

      expect(page).to have_content("Bigge")
      expect(page).to have_content("South State Stree")
      expect(page).to have_content("Salt Lake City")
      expect(page).to have_content("UT")
      expect(page).to have_content("84105")
      expect(page).to have_content("Why would you be a good pet parent?")
      
      expect(page).to have_content("In Progress")
    end
  end
end