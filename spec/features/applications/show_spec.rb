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

  describe 'US 5' do
    describe 'Add a pet to an application' do
      it 'adopts a pet' do
        
        app1 = Application.create!(name: "Odell", street_address: "123 Dog Lane", city: "Denver", state: "Colorado", zip_code: 70890, description: "Practicing for when I have kids", status: "In Progress")
        pet = Pet.create!(adoptable: false, age: 10, breed:"Huski", name: "Pete",shelter_id: shelter1.id)


        visit "/applications/#{app1.id}"


        fill_in :pet_name, with: "#{pet.name}"
          
        click_on("Search")

        expect(current_path).to eq("/applications/#{app1.id}")

        # save_and_open_page
        expect(page).to have_content('Pete')

        expect(page).to have_button('Adopt this pet')

        click_button('Adopt this pet')

        expect(current_path).to eq("/applications/#{app1.id}")

        within ".adoptpet" do 
          expect(page).to have_content('Pete')
        end

      end
    end
  end

  describe '#US 6' do
    describe 'submit an Application' do
      it " has a section why I would make a good owner for these pet(s)" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
        pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        
        visit "/applications/#{applicant.id}"

        expect(page).to have_content('In Progress')
        within ".why_I_would_make_a_good_owner" do 
          expect(page).to have_content("why I would make a good owner for the pet(s)?")
          
          expect(page).to have_field("why I would make a good owner for the pet(s)?")
          fill_in :why_i_would_make_a_good_owner, with: "Great with pets"
          
          click_on("Submit Application")
        end 
        # save_and_open_page

        expect(current_path).to eq("/applications/#{applicant.id}")
        # save_and_open_page
        expect(page).to have_content('Pending')

        expect(page).to_not have_content('why I would make a good owner for these pet(s)')
      end
    end
  end

  describe 'US 7' do
    describe 'No pets on an application' do
      it 'does not show a section to submit my application' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
        pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{applicant.id}"
        
        within ".nopets" do 
          expect(page).to_not have_content('why I would make a good owner for these pet(s)')
        end
        
      end
    end
  end

  describe 'US 8 ' do
    describe 'partial matches for pets' do
      it 'displays the pet I want even though its searched PARTIALLY' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
        pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{applicant.id}"

        fill_in :pet_name, with: "Scoob"

        click_on("Search")

        # save_and_open_page
       
        #DO I need a within block here?
        expect(page).to have_content('Scooby')
        

      end
    end
  end

  describe 'US 9 ' do
    describe 'Case Insensitive Matches for Pet Names' do
      it 'displays the pet I want even though its incase sensitive search' do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
        pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{applicant.id}"

        fill_in :pet_name, with: "sCoOb"

        click_on("Search")

        # save_and_open_page
       
        #DO I need a within block here too?
        expect(page).to have_content('Scooby')
        

      end
    end
  end

    
end
