require "rails_helper"

RSpec.describe "New Applicant" do
  before(:each) do
    @applicant_1 = Applicant.create(name: "Ian", street_address: "4130 cleveland ave", city: "New Orleans", state: "louisiana", zip_code: "70119", description: "I wanna have cat", status: "In Progress")
  end

  it "should display a new applicant form" do
    visit "/applicants/new"

    fill_in(:name, with: "Ian")
    fill_in(:street_address, with: "4130 cleveland ave")
    fill_in(:city, with: "New Orleans")
    fill_in(:state, with: "louisiana")
    fill_in(:zip_code, with: "70119")
    fill_in(:description, with: "I wanna have cat")

    click_button "Submit"

    expect(current_path).to eq("/applicants/#{Applicant.last.id}")

    expect(page).to have_content(@applicant_1.name)
    expect(page).to have_content(@applicant_1.street_address)
    expect(page).to have_content(@applicant_1.city)
    expect(page).to have_content(@applicant_1.state)
    expect(page).to have_content(@applicant_1.zip_code)
    expect(page).to have_content(@applicant_1.description)
  end
  
  it "should have a redirect with a warning if applicant form is not filled out" do
    visit "/applicants/new"

    fill_in(:name, with: "Ian")
    fill_in(:street_address, with: "4130 cleveland ave")
    fill_in(:city, with: "New Orleans")
    fill_in(:state, with: "louisiana")
    fill_in(:zip_code, with: "70119")
    

    click_button "Submit"
    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("ERROR: Form incomplete, please fill out missing information")
  end
end






# 3. Starting an Application, Form not Completed

# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.