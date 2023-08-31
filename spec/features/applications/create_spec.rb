require "rails_helper"

RSpec.describe "application creation" do
  it "shows application and all it's attributes" do
    
    #arrange
                        
    #act
    visit("/pets")
    click_link('Start an Application')
    fill_in('name', with: 'John')
    fill_in('address', with: "New Street")
    fill_in('city', with: 'Somewhere')
    fill_in('state', with: "Colorado")
    fill_in('zip', with: '01234')
    click_button('Submit')
    #assert
    expect(page).to have_content("John")
    expect(page).to have_content("New Street")
    expect(page).to have_content("Somewhere")
    expect(page).to have_content("Colorado")
    expect(page).to have_content("01234")
    # expect(page).to have_content(application.pet_names)
    expect(page).to have_content("In Progress")
  end
end