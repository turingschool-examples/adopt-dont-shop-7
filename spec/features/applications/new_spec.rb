require "rails_helper"

RSpec.describe "Applications" do

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

      
      fill_in(:name, with: 'Biggie')
      fill_in(:street_address, with: 'South State Street')
      fill_in(:city, with: 'Salt Lake City')
      fill_in(:state, with: 'UT')
      fill_in(:zip_code, with: '84105')
      fill_in(:description, with: 'Why would you be a good pet parent?')
      
      # expect(page).to have_link "Submit Application", href: "/applications"
      click_button('Submit Application')

      expect("Name:").to appear_before("Biggie")
      expect(page).to have_content("Biggie")
      expect(page).to have_content("South State Street, Salt Lake City, UT, 84105")
    
      expect(page).to have_content("Why would you be a good pet parent?")
      
      expect(page).to have_content("Pending")
    end
  end
end