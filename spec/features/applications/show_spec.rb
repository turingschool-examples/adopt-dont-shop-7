require "rails_helper"

RSpec.describe "the application show" do
  it "shows the application and all it's attributes" do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "Pending"
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

  it 'can search for pets on an application show page if that application has not been submitted' do
    application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
      )

      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

      pet_1 = Pet.create!(
        adoptable: true,
        age: 1,
        breed: "sphynx",
        name: "Lucille Bald",
        shelter_id: shelter.id
        )

      visit "/applications/#{application.id}"

      expect(page).to have_field("Search")

      fill_in(:search, with: "Lucille Bald")
      click_button("Submit")

      expect(current_path).to eq("/applications/#{application.id}")

      expect(page).to have_content("Lucille Bald")
  end
end
