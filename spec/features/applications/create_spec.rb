require "rails_helper"

RSpec.describe "New Application Page" do 
  it "has a link to start an application" do 
    visit "/pets"

    expect(page).to have_link("Start an Application")
    
    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("New Application")
  end

  it "has a form to create a new application" do 
    visit "/applications/new"

    expect(page).to have_content("Name:")
    expect(page).to have_field(:name)
    expect(page).to have_content("Street address:")
    expect(page).to have_field(:street)
    expect(page).to have_content("City:")
    expect(page).to have_field(:city)
    expect(page).to have_content("State:")
    expect(page).to have_field(:state)
    expect(page).to have_content("Zip code:")
    expect(page).to have_field(:zip)
    expect(page).to have_content("How can I provide a good home?:")
    expect(page).to have_field(:good_home)

    fill_in(:name, with: "Matt")
    fill_in(:street, with: "2636 Vrain St.")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "CO")
    fill_in(:zip, with: "80212")
    fill_in(:good_home, with: "B/c I'm awesome!")

    expect(page).to have_button("Submit")

    click_button "Submit" 

    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}")
    
    expect(page).to have_content("Matt")
    expect(page).to have_content("2636 Vrain St.")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("80212")
    expect(page).to have_content("B/c I'm awesome!")
    expect(page).to have_content("In progress")
  end
  it "can not create an application with any field empty" do 
    visit "/applications/new"

    fill_in(:name, with: "")
    fill_in(:street, with: "2636 Vrain St.")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "CO")
    fill_in(:zip, with: "80212")
    fill_in(:good_home, with: "B/c I'm awesome!")

    click_button "Submit" 

    expect(current_path).to eq("/applications/new")
    
    expect(page).to have_content("Application not created: Required information missing.")
    expect(page).to have_button("Submit")

    visit "/applications/new"

    fill_in(:name, with: "Matt")
    fill_in(:street, with: "2636 Vrain St.")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "")
    fill_in(:zip, with: "80212")
    fill_in(:good_home, with: "B/c I'm awesome!")

    click_button "Submit" 

    expect(current_path).to eq("/applications/new")
    
    expect(page).to have_content("Application not created: Required information missing.")
    expect(page).to have_button("Submit")
  end
end 