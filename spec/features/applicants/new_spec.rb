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
end






# 2. Starting an Application

# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
#   - Description of why I would make a good home
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"