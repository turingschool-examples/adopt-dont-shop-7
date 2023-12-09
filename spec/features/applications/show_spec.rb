require 'rails_helper'

RSpec.describe 'application show spec', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @app_1 = Application.create!(name: "Larry", full_address: "Larry's address", description: "Larry's story", status: 2,)
      @app_2 = Application.create!(name: "John", full_address: "John's address", description: "John's story", status: 1,)
    end
  end

  # 1. Application Show Page
  it "displays the applicant information" do
    # When I visit an applications show page
    visit "/application/#{@app_2.id}"
    # Then I can see the following:
    # - Name of the Applicant
    expect(page).to have_content(@app_1.name)
    # - Full Address of the Applicant including street address, city, state, and zip code
    expect(page).to have_content(@app_1.address)
    # - Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content(@app_1.description)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    expect(page).to have_content()
    expect(current_path).to eq()
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  end
end


it 'has readable attributes' do
  expect(@).to eq()
end