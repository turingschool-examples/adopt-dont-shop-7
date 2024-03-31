require "rails_helper"

RSpec.describe "The Admin Application Show Page" do
 describe "User Story 13" do
  before(:each) do
    @application = Application.create!(
      name: 'Lance Bass',
      description: 'I love animals.',
      street_address: '1234 Sesame Street',
      city: 'New York City',
      state: 'NY',
      zip_code: 10001,
      status: "In Progress"
    )

    @shelter = Shelter.create(
      name: "Aurora shelter", 
      city: "Aurora, CO",
      foster_program: false, 
      rank: 9
    )

    @pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: @shelter.id
    )
    @pet_2 = Pet.create!(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: @shelter.id
    )
    @pet_3 = Pet.create!(
      adoptable: false,
      age: 2,
      breed: "saint bernard",
      name: "Beethoven",
      shelter_id: @shelter.id
    )
  end

  it "has a reject pet button" do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content("Lobster")
    expect(page).to have_content("saint bernard")

    expect(page).to have_content("Pending")

    expect(page).to have_button("Reject")
    click_on "Reject"
    expect(current_path).to eq("/admin/applications/#{@application.id}")

    expect(page).to_not have_content("Approve")
    expect(page).to have_content("Rejected")
  end
 end
end