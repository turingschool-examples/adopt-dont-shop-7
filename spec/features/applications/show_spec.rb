require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: "Fredrich Longbottom", address: "1234 1st St", city: "Denver", state: "CO", zip: "80202", description_why: "I love creatures.")

    visit "/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content(application.name)
    expect(page).to have_content("Application status: #{application.status}")
    expect(page).to have_content("Address: #{application.address}, #{application.city}, #{application.state} #{application.zip}")
    expect(page).to have_content("Reasons for adoption: #{application.description_why}")
    expect(page).to have_content("Pets on this application:")
  end
end