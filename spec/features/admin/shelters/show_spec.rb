require "rails_helper"

RSpec.describe 'admin#shelters' do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pirate = Pet.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @clawdia = Pet.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter_1.id)
    @pickle = Pet.create!(name: "Pickle", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter_1.id)
    @luna = Pet.create!(name: "Luna", breed: "shorthair", age: 3, adoptable: false, shelter_id: @shelter_1.id)
    @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @bruno = Pet.create!(adoptable: true, age: 4, breed: "doberman", name: "Bruno", shelter_id: @shelter_1.id)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending") 
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
   
      expect(page).to have_content("Statistics")
      expect(page).to have_content("Average Pet Age: 4")
    end

    # 23. Count of Adoptable Pets
    it 'gives number of pets at that shelter that are adoptable' do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Statistics")
      expect(page).to have_content("Adoptable Pets at this Location: 3")
    end

    # 24. Count of Pets that have been Adopted
    it 'gives number of pets at that shelter that have been adopted' do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Statistics")
      expect(page).to have_content("Pets that have been adopted: 2")
    end

    # 25. Action Required
    it "lists pets that have a pending application and have not yet been marked" do
      @trevor.add_pet(@clawdia)
      visit "/admin/shelters/#{@shelter_1.id}"


      expect(page).to have_content("Action Required")

      within('section', :text => "Action Required") do
        expect(page).to have_content(@clawdia.name)
        expect(page).to have_content(@bruno.name)
      end
    end
  end
end