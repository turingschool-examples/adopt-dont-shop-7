require "rails_helper"

RSpec.describe "the applicant show" do
  it "shows the applicant and all it's attributes" do
    applicant_1 = Applicant.create(name: "Bob",  street_address: "1234 a street", city: "Irvine CA", state: "TX", zip_code: "58200", application_status:  "In Progress", pets: 9)


    visit "/applicants/#{applicant.id}"

    save_ans_open_page
    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.application_status)
  end
end