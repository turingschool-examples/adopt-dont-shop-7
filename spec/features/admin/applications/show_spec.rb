require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to reject the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I rejected, I do not see a button to approve or reject this pet
# And instead I see an indicator next to the pet that they have been rejected
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
# As a visitor
# When there are two applications in the system for the same pet
# When I visit the admin application show page for one of the applications
# And I approve or reject the pet for that application
# When I visit the other application's admin show page
# Then I do not see that the pet has been accepted or rejected for that application
# And instead I see buttons to approve or reject the pet for this specific application

  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow")
    @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
    @pet_3 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester")
    @pet_4 = @shelter_3.pets.create!(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna")

    @application_1 = Application.create!(name: "Test 1", street_address: "123 street", city: "denver", state: "co", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")
    @application_2 = Application.create!(name: "Test 2", street_address: "12323 street", city: "lakewood", state: "ca", zip_code: 80023, endorsement: "Still the raddest", status: "Pending")

    @application_pet_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @application_pet_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)
    @application_pet_3 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
  end

  it 'has a button to approve or reject a pet on an application' do
    visit "/admin/applications/#{@application_1.id}"

    within "##{@pet_1.id}" do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
    end
    within "##{@pet_2.id}" do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
    end
  end

  it 'can accept the application for a pet and see an indicator that that application was accepted' do
    visit "/admin/applications/#{@application_1.id}"

    within "##{@pet_1.id}" do
      click_on "Approve Application"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within "##{@pet_1.id}" do
      expect(page).not_to have_button("Approve Application")
      expect(page).not_to have_button("Reject Application")
      expect(page).to have_content("Application Approved")
    end
  end

  it 'can reject the application for a pet and see an indicator that that application was rejected' do
    visit "/admin/applications/#{@application_1.id}"

    within "##{@pet_1.id}" do
      click_on "Reject Application"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within "##{@pet_1.id}" do
      expect(page).not_to have_button("Approve Application")
      expect(page).not_to have_button("Reject Application")
      expect(page).to have_content("Application Rejected")
    end
  end

  it 'will not effect a separate application for the same pet if the pet is approved on a separate application' do
    visit "/admin/applications/#{@application_1.id}"

    within "##{@pet_1.id}" do
      click_on "Approve Application"
    end

    visit "/admin/applications/#{@application_2.id}"

    within "##{@pet_1.id}" do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
      expect(page).not_to have_content("Application Accepted")
    end
  end

  it 'will not effect a separate application for the same pet if the pet is rejected on a separate application' do
    visit "/admin/applications/#{@application_1.id}"

    within "##{@pet_1.id}" do
      click_on "Reject Application"
    end

    visit "/admin/applications/#{@application_2.id}"

    within "##{@pet_1.id}" do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
      expect(page).not_to have_content("Application Rejected")
    end
  end
end