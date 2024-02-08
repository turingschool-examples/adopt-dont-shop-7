require 'rails_helper'

RSpec.describe "Application show" do

    it 'shows the name of the applicant ' do
        applicant_1 = Applicant.create!(name: "Lance", street_address: "123 sesame street", city: "Brooklyn", state: "New York", zip_code: "10012")
        visit "/applicant/#{applicant_1.id}"

        expect(page).to have_content(applicant_1.name)
        expect(page).to have_content(applicant_1.street_address)
        expect(page).to have_content(applicant_1.city)
        expect(page).to have_content(applicant_1.state)
        expect(page).to have_content(applicant_1.zip_code)
    end
end