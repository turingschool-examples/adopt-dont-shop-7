require "rails_helper"

RSpec.describe 'admin#shelters' do
  before :each do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)

    @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @bruno = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: @shelter_1.id)
    @shelter_4.pets.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie")
    @bailey = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bailey", shelter_id: @shelter_4.id)
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")  
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", status: "Pending")
    @john.add_pet(@bruno)
    @trevor.add_pet(@bailey)
  end

  describe 'Admin Shelters#index' do
    # User Story 10, Admin Shelters Index (SQL ONLY)
    it 'shows all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'
      
      within('section', :text => 'All Shelters') do
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end
    end
  

    # User Story 11, Shelters with Pending Applications (ACTIVERECORD ONLY)
    it 'shows the name of every shelter that has a pending application' do
      visit '/admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")
      within('section', :text => 'Shelters with Pending Applications') do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_4.name)
      end
    end

    it 'will not show shelters with no pending applications' do
      visit '/admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")
      within('section', :text => 'Shelters with Pending Applications') do
        expect(page).to_not have_content(@shelter_2.name)
        expect(page).to_not have_content(@shelter_3.name)
      end
    end

    # 20. Shelters with Pending Applications Listed Alphabetically
    it 'shows shelters with pending applications in alpha order' do
      visit '/admin/shelters'
      
      expect(page).to have_content("Shelters with Pending Applications")
      within('section', :text => 'Shelters with Pending Applications') do
        expect(@shelter_1.name).to appear_before(@shelter_4.name)
      end
    end

    # 21. Admin Shelters Show Page Links
    it 'has links to admin shelter show pages on index' do
      visit '/admin/shelters'
      expect(page).to have_link(@shelter_1.name)
      expect(page).to have_link(@shelter_2.name)
      expect(page).to have_link(@shelter_3.name)
      expect(page).to have_link(@shelter_4.name)

      click_link(@shelter_1.name)

      expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
    end
  end
end