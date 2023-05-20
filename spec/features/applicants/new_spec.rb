require "rails_helper"

RSpec.describe "Applicant New Page" do
  it "New application form page" do
    visit "/applicants/new"

    fill_in(:name, with: "Jeff Nelson")
    fill_in(:street_address, with: "234 Meadows Lane")
    fill_in(:city, with: "Lake City")
    fill_in(:state, with: "IN")
    fill_in(:zip_code, with: "42894")
    fill_in(:qualification, with: "Love All PETS!")

    click_button("Submit Application")
    
    expect(current_path).to eq("/applicants/#{Applicant.all.last.id}")
save_and_open_page
    expect(page).to have_content("Jeff Nelson")
    expect(page).to have_content("234 Meadows Lane")
    expect(page).to have_content("Lake City")
    expect(page).to have_content("IN")
    expect(page).to have_content("42894")
    expect(page).to have_content("Love All PETS!")
    expect(page).to have_content("In Progress")
  end

end