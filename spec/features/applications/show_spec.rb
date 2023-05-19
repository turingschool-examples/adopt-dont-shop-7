require 'rails_helper'

RSpec.describe '/applications/:id', type: :feature do 
  before(:each) do 
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @susie = Application.create!(
      name: 'Susie', 
      street_address: '5234 S Jamaica', 
      city: 'Fargo', 
      state: 'MI', 
      zip: '45896', 
      description: 'Loves alligators.', 
      status: 'Pending'
    )
    @tom = Application.create!(
      name: 'Thomas', 
      street_address: '5234 S Jefferson', 
      city: 'Julian', 
      state: 'AL', 
      zip: '43896', 
      description: 'Has owned a pet.', 
      status: 'In Progress'
    )
    ApplicationPet.create!(pet: @pet_1, application: @susie)
    ApplicationPet.create!(pet: @pet_2, application: @susie)
    
    ApplicationPet.create!(pet: @pet_1, application: @tom)
    ApplicationPet.create!(pet: @pet_2, application: @tom)
    ApplicationPet.create!(pet: @pet_3, application: @tom)
  end

  #User story 1

  describe 'Application Show Page' do
    it 'shows applicant information' do 
      visit "/applications/#{@susie.id}"
      expect(page).to have_content(@susie.name)
      expect(page).to have_content("Street Address: #{@susie.street_address}")
      expect(page).to have_content("City: #{@susie.city}")
      expect(page).to have_content("State: #{@susie.state}")
      expect(page).to have_content("Zip Code: #{@susie.zip}")
      expect(page).to have_content("Description: #{@susie.description}")
      expect(page).to have_content("Status: #{@susie.status}")
      
      expect(page).to_not have_content(@tom.name)
      expect(page).to_not have_content("Street Address: #{@tom.street_address}")
      expect(page).to_not have_content("City: #{@tom.city}")
      expect(page).to_not have_content("State: #{@tom.state}")
      expect(page).to_not have_content("Zip Code: #{@tom.zip}")
      expect(page).to_not have_content("Description: #{@tom.description}")
      expect(page).to_not have_content("Status :#{@tom.status}")
    end
    
    it 'shows different applicant information' do 
      visit "/applications/#{@tom.id}"
      expect(page).to have_content(@tom.name)
      expect(page).to have_content("Street Address: #{@tom.street_address}")
      expect(page).to have_content("City: #{@tom.city}")
      expect(page).to have_content("State: #{@tom.state}")
      expect(page).to have_content("Zip Code: #{@tom.zip}")
      expect(page).to have_content("Description: #{@tom.description}")
      expect(page).to have_content("Status: #{@tom.status}")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
      
      expect(page).to_not have_content(@susie.name)
      expect(page).to_not have_content("Street Address: #{@susie.street_address}")
      expect(page).to_not have_content("City: #{@susie.city}")
      expect(page).to_not have_content("State: #{@susie.state}")
      expect(page).to_not have_content("Zip Code: #{@susie.zip}")
      expect(page).to_not have_content("Description:#{@susie.description}")
      expect(page).to_not have_content("Status:#{@susie.status}")
    end

    it 'applicant show page has link to each pet show page' do 
      visit "/applications/#{@susie.id}"
      expect(page).to have_link("#{@pet_1.name}", :href => "/pets/#{@pet_1.id}" )
      expect(page).to have_link("#{@pet_2.name}", :href => "/pets/#{@pet_2.id}")
      
      click_link("#{@pet_2.name}")
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end
  end
end