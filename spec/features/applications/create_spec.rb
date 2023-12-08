require "rails_helper"

RSpec.describe "the application create" do
  it "display's the applicants info" do

    visit "/applications/new"

    expect(page).to have_content("New Application")
    
    fill_in "Applicant name", with: "Sam Puttman"
    fill_in "Address", with: "1940 Key West Drive"
    fill_in "City", with: "Arnold"
    fill_in "State", with: "Missouri"
    fill_in "Zip code", with: 63042
    fill_in "Description of why I would make a good home", with: "Castiel needs a new friend!"

    click_button "Submit"
    visit "/applications"

    expect(page).to have_content("Sam Puttman")
    expect(page).to have_content("1940 Key West Drive")
    expect(page).to have_content("Arnold")
    expect(page).to have_content("Missouri")
    expect(page).to have_content(63042)
    expect(page).to have_content("Castiel needs a new friend!")
  end
end