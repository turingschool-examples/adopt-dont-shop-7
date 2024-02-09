require 'rails_helper'

RSpec.describe 'Application show' do
  let!(:app1) {Application.create!(name: "Odell", street_address: "123 Dog Lane", city: "Denver", state: "Colorado", zip_code: 70890, description: "Practicing for when I have kids", status: "In Progress")}
  let!(:shelter1) {Shelter.create!({foster_program: true, name: "Martin's Shelter", city: "Denver", rank: 5})}
  let!(:pet1) {app1.pets.create!(adoptable: false, age: 10, breed:"Huski", name: "Billy", shelter_id: shelter1.id)}

  describe 'User story 1' do
    it 'show applications attributes' do
      visit "applications/#{app1.id}"

      expect(page).to have_content(app1.name)
      expect(page).to have_content(app1.street_address)
      expect(page).to have_content(app1.city)
      expect(page).to have_content(app1.state)
      expect(page).to have_content(app1.zip_code)
      expect(page).to have_content(app1.description)
      expect(page).to have_content(app1.status)
      expect(page).to have_content(pet1.name)
      expect(page).to have_content("Billy")

      expect(page).to have_link("#{pet1.name}")

      click_on("#{pet1.name}")

      expect(current_path).to eq("/pets/#{pet1.id}")
    end
  end

  describe 'US 4 Sad path' do
    describe 'Searching for a pet that doesnt exist' do
      it 'searches pets' do
      visit "/applications/#{app1.id}"

        within ".pet" do 
          fill_in :pet_name, with: "Bob"
          # save_and_open_page
          click_on("Search")

          expect(current_path).to eq("/applications/#{app1.id}")

          expect(page).to_not have_content('Bob')
        end
      end
    end
  end

  describe 'US 4 Happy path' do
    describe 'Searching for a pet that exists' do
      it 'searches pets' do
      visit "/applications/#{app1.id}"

        within ".pet" do 
          fill_in :pet_name, with: "Billy"
          # save_and_open_page
          click_on("Search")

          expect(current_path).to eq("/applications/#{app1.id}")

          expect(page).to have_content('Billy')
        end
      end
    end
  end

    
end
