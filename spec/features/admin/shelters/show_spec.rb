require "rails_helper"

RSpec.describe 'admin#shelters' do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @bruno = Pet.create!(adoptable: true, age: 4, breed: "doberman", name: "Bruno", shelter_id: @shelter_1.id)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @john.add_pet(@bruno)
  end

  describe 'shelters show page' do
    # 19. Admin Shelters Show Page
    it 'shows shelters name and full address' do
      visit "/admin/shelters/#{@shelter_1.id}"
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to_not have_content(@shelter_1.foster_program)
      expect(page).to_not have_content(@shelter_1.rank)
      expect(page).to_not have_content(@shelter_2.name)   
    end

    # 22. Average Pet Age
    it 'gives average age of all adoptable pets for that shelter' do
      visit "/admin/shelters/#{@shelter_1.id}"
      save_and_open_page
      expect(page).to have_content("Statistics")
      expect(page).to have_content("Average Pet Age: 4")
    end
  end
end