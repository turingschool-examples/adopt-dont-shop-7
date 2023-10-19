require "rails_helper"

RSpec.describe "Application Show Page" do

  before(:each) do
    @application1 = Application.create!(name: "Julie Johnson", address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", to_adopt: "Auggie", status: "In Progress")
    @application2 = Application.create!(name: "Steve Smith", address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", to_adopt: "Rue", status: "Accepted")
  end 

  it "should display the applicants information" do
    visit "/applications/#{@application1.id}"

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip_code)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
    save_and_open_page
  end
end