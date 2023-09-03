require 'rails_helper'

RSpec.describe 'New Applicant' do
  describe 'When I visit the new applicant form by clicking a link on the index' do 
    it 'I can create a new applicant' do
      visit '/pets'

      click_link 'Start an Application'

      fill_in 'name', with: 'Megan'
      fill_in 'street_address', with: '98547 '
      fill_in 'city', with: 'Littleton'
      fill_in 'state', with: 'CO'
      fill_in 'zipcode', with: '80909'
      fill_in 'describe', with: 'good pet owner'


      expect(current_path).to eq('/applicants/new')

      click_on 'Apply for Pet'

      expect(current_path).to eq("/applicants/#{applicant.id}")
    end
  end
end