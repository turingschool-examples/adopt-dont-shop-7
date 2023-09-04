require 'rails_helper'

RSpec.describe 'New Applicant' do
  describe 'When I visit the new applicant form by clicking a link on the index' do 
    it 'I can create a new applicant' do
      visit '/pets'

      click_link 'Start an Application'
      
      expect(current_path).to eq('/applicants/new')

      fill_in 'name', with: 'Megan'
      fill_in 'street_address', with: '98547 '
      fill_in 'city', with: 'Littleton'
      fill_in 'state', with: 'CO'
      fill_in 'zipcode', with: '80909'
      fill_in 'description', with: 'good pet owner'

      click_on 'Apply for Pet'
      applicant1 = Applicant.last
      expect(current_path).to eq("/applicants/#{applicant1.id}")
      expect(page).to have_content("Megan")
      expect(page).to have_content("98547")
      expect(page).to have_content("Littleton")
      expect(page).to have_content("CO")
      expect(page).to have_content("80909")
      expect(page).to have_content("good pet owner")
      expect(page).to have_content("In Progress")
    end
  end

    it "cannot create an applicant without a name, street_address,city, state, zipcode, & description" do
      visit "/applicants/new"

      click_on "Apply for Pet"

      expect(page).to have_content("Applicant not created: Required information missing.")
      expect(page).to have_button("Apply for Pet")
    end
  end
end