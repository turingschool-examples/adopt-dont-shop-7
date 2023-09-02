require 'rails_helper'

RSpec.describe "application show page", type: :feature do 
  before(:each) do 
    load_test_data
  end

  it "shows the name of the applicant and all of its attributes" do 
    visit "/applications/#{applicant1.id}"

      expect(page).to have_content(@applicant1.name)
      expect(page).to have_content(@applicant1.address)
      expect(page).to have_content(@applicant1.description)
      expect(page).to have_content(@applicant1.pets)
  end
end