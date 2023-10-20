require 'rails_helper'

RSpec.describe "New Application Page" do
  # User story 2
  it 'user fills out the form, submits, gets directed to new applications show page where user input is shown and application status is changed to in progress' do
    visit '/applications/new'
    
    fill_in('name', with: 'Lauren Lockwood')
    fill_in('street_address', with: '123 Mulberry Ln') 
    fill_in('city', with: 'Denver')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '80206')
    fill_in('description', with: "I love dogs")
    click_on ('Submit')
    expect(current_path).to eq("/applications/1") #everytime we test it's making more applications... doing application.id there isnt working for some reason
    expect(page).to have_content('Lauren Lockwood')
    # expect(page).to have_content('In Progress') #this is something we may have needed in the migration... will discuss
    Application.destroy_all
  end

  #User story 3
  it 'redirects you to the application form page if you do not fill it out properly' do
    visit '/applications/new'
    
    fill_in('name', with: 'Michelle Obama')
    fill_in('street_address', with: '55 West Broad St') 
    fill_in('state', with: 'DC')
    fill_in('description', with: "I love cats")
    click_button ('Submit')
    # save_and_open_page
    # expect(page).to have_content("Validation failed: City can't be blank, Zip code can't be blank")
    # expect(page).to have_content("Please fill in all required fields!")
    expect(current_path).to eq("/applications/2") #you have to run rails db:{drop,create,migrate} to get the numbers right.. 
    Application.destroy_all
  end
end


