require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @application = Application.create!(name: "Fredrich Longbottom", address: "1234 1st St", city: "Denver", state: "CO", zip: "80202", description_why: "I love creatures.")
    @shelter_1 = Shelter.create!(
      foster_program: false,
      name: "Denver Animal Shelter",
      city: "Denver",
      rank: 1
    )
    @pet_1 = @shelter_1.pets.create!(
      adoptable: true,
      age: 4,
      breed: "Husky",
      name: "Bailey"
      )
    @pet_2 = @shelter_1.pets.create!(
      adoptable: true,
      age: 2,
      breed: "Great Dane",
      name: "Charlie"
    )

      visit "/applications/#{@application.id}"
  end

  it "shows the application and all it's attributes" do
    expect(page).to have_content(@application.name)
    expect(page).to have_content("Application status: #{@application.status}")
    expect(page).to have_content("Address: #{@application.address}, #{@application.city}, #{@application.state} #{@application.zip}")
    expect(page).to have_content("Description of why I would make a good home:")
    expect(page).to have_content(@application.description_why)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_content("Pets on this application:")
  end

  it "can search for pets and filter by name" do
    fill_in "search", with: "Bailey"
    expect(page).to have_content("Charlie")
    click_on "Search"
    expect(page).to have_content("Bailey")
    expect(page).to_not have_content("Charlie")
  end

  it 'does not render search if application is submitted' do
    submitted = Application.create!(name: "Karl Crabs", address: "1234 4th ave", city: "Seattle", state: "Wa", zip: "80202", description_why: "I love creatures.")
    submitted.update!(status: "Submitted")
    visit "/applications/#{submitted.id}"
    expect(page).to_not have_content("Search")
  end

  it "can add pets to application from pets list" do
    within "#adoptable-pet-#{@pet_1.id}" do
    click_on "Adopt this pet"
  end
end
end
