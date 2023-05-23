require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @application = Application.create!(name: "Fredrich Longbottom",
                                       address: "1234 1st St",
                                       city: "Denver",
                                       state: "CO",
                                       zip: "80202",
                                       description_why: "I love creatures."
                                       )
    @shelter_1 = Shelter.create!(
      foster_program: false,
      name: "Denver Animal Shelter",
      city: "Denver",
      rank: 1
    )
    @pet_1 = @shelter_1.pets.create!(
      adoptable: true,
      age: 3,
      breed: "Jack Russell Terrier",
      name: "Alphonso",
      shelter_id: 1
    )

    @pet_2 = @shelter_1.pets.create!(
      adoptable: true,
      age: 4,
      breed: "Husky",
      name: "Bailey",
      shelter_id: 1
    )

    @pet_3 = @shelter_1.pets.create!(
      adoptable: true,
      age: 2,
      breed: "Great Dane",
      name: "Charlie",
      shelter_id: 1
    )

    @pet_4 = @shelter_1.pets.create!(
      adoptable: true,
      age: 5,
      breed: "Golden",
      name: "Doug",
      shelter_id: 1
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
    expect(page).to_not have_content("Bailey")
    click_on "Search"
    expect(page).to have_content("Bailey")
    expect(page).to_not have_content("Alphonso")
    expect(page).to_not have_content("Charlie")
    expect(page).to_not have_content("Doug")
  end

  it "can search for pets and filter by incomplete name" do
    fill_in "search", with: "Bail"
    expect(page).to_not have_content("Bailey")
    click_on "Search"
    expect(page).to have_content("Bailey")
    expect(page).to_not have_content("Alphonso")
    expect(page).to_not have_content("Charlie")
    expect(page).to_not have_content("Doug")
  end

  it "can search for pets and filter by incomplete name, case insensitive" do
    fill_in "search", with: "d"
    expect(page).to_not have_content("Charlie")
    click_on "Search"
    expect(page).to have_content("Doug")
    expect(page).to_not have_content("Alphonso")
    expect(page).to_not have_content("Bailey")
    expect(page).to_not have_content("Charlie")
  end

  it "does not render search if application is submitted" do
    submitted = Application.create!(name: "Karl Crabs",
                                    address: "1234 4th ave",
                                    city: "Seattle", state: "Wa",
                                    zip: "80202",
                                    description_why: "I love creatures."
                                    )
    submitted.update!(status: "Submitted")
    visit "/applications/#{submitted.id}"
    expect(page).to_not have_content("Search")
  end

  it "can add pets to application from pets list" do
    within "#pets-on-application" do
      expect(page).to_not have_content(@pet_1.name)
    end

    fill_in :search, with: "#{@pet_1.name}"
    click_on "Search"
    within "#adoptable-pet-#{@pet_1.id}" do
      click_on "Adopt this pet"
      expect(current_path).to eq("/applications/#{@application.id}")
    end

    within "#pets-on-application" do
      expect(page).to have_content(@pet_1.name)
    end
  end

  describe "can submit applicaiton" do
    it "has a submit application buttion" do
      visit "/applications/#{@application.id}"
      fill_in :search, with: "#{@pet_1.name}"
      click_on "Search"
      within "#adoptable-pet-#{@pet_1.id}" do
        click_on "Adopt this pet"
        expect(current_path).to eq("/applications/#{@application.id}")
      end
      expect(page).to have_content("Why I would make a good home for these pets")
      expect(page).to have_content("Submit Application")
      click_on "Submit Application"
      expect(current_path).to eq("/applications/#{@application.id}")

    end
  end
end
