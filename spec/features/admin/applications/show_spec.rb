require 'rails_helper'

RSpec.describe "Admin Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
  end

  describe '#Managing Approvals' do
    before :each do
      @application.pets << @pet_3
      @application.pets << @pet_5
    end

  ## USER STORY 12
    it 'when viewing the admin application show page, there are buttons to approve the application for each pet' do
      visit "/admin/applications/#{@application.id}"
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_5.name)
      expect(page).to have_content("Approve #{@pet_3.name}")
      expect(page).to have_content("Approve #{@pet_5.name}")
    end

    it 'each pet has an approve and reject button' do
      visit "/admin/applications/#{@application.id}"
      expect(page).to have_content("Approve #{@pet_5.name}")
      expect(page).to have_content("Reject #{@pet_5.name}")
    end

    it 'admin may click the adoption and it will change the status of the pet to approved and status as not adoptable' do
      visit "/admin/applications/#{@application.id}"
      click_button "Approve #{@pet_3.name}"
      expect(page).to_not have_content("Approve #{@pet_3.name}")
      expect(page).to have_content("Approved")
      expect(page).to have_content("Approve #{@pet_5.name}")
    end

  ## USER STORY 13

    it 'admin may reject a pet from being adopted and neither button is available' do
      visit "/admin/applications/#{@application.id}"

      within(@pet_5.id) do
      click_button "Reject Pet"
      expect(page).to_not have_content("Approve Pet")
      expect(page).to_not have_content("Reject Pet")
      expect(page).to have_content("Rejected")
    end
  end

  # USER STORY 14
  xit "approved/rejected pets on one application do not affect other applications" do

    visit "/admin/applications/#{@application_1.id}"

    within(@pet_1) do
      click_button("Reject")
      expect(page).to have_content("Rejected")
    end

    within(@pet_2) do
      click_button("Approve")
      expect(page).to have_content("Approved")
    end

    visit "/admin/applications/#{@application_2.id}"

    within(@pet_1) do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within(@pet_2) do
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

end
