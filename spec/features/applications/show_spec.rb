require 'rails_helper'

RSpec.describe '/applications/:id', type: :feature do 
  before(:each) do 
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

      expect(page).to_not have_content(@susie.name)
      expect(page).to_not have_content("Street Address: #{@susie.street_address}")
      expect(page).to_not have_content("City: #{@susie.city}")
      expect(page).to_not have_content("State: #{@susie.state}")
      expect(page).to_not have_content("Zip Code: #{@susie.zip}")
      expect(page).to_not have_content("Description:#{@susie.description}")
      expect(page).to_not have_content("Status:#{@susie.status}")
    end
  end
end