require "rails_helper"

RSpec.describe "application creation" do
  it "shows application and all it's attributes" do
    
    #arrange
                        
    #act
    visit("/pets")
    click_link('Start an Application')
    fill_in('Name', with: 'John')
    fill_in('Address', with: "New Street")
    fill_in('City', with: 'Somewhere')
    fill_in('State', with: "Colorado")
    fill_in('Zip', with: '01234')
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

  it "denies the application if the form is not filled out correctly" do
    #arrange
                        
    #act
    visit("/pets")
    click_link('Start an Application')
    fill_in('Name', with: 'John')
    fill_in('Address', with: "New Street")
    fill_in('City', with: 'Somewhere')
    fill_in('State', with: "Colorado")
    click_button('Submit')
    #assert
    expect(page).not_to have_content("John")

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("Zip can't be blank")
  end
end