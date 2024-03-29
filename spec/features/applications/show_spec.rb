require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all it's attributes" do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      status: 'Pending',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 00001
      )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
  end
end
