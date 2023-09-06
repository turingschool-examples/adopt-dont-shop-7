require "rails_helper"

RSpec.describe "Admin show" do
  before :each do
    @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
    @pet_1 = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
    @pet_2 = @shelter.pets.create!(name: 'Buddy', breed: 'gorilla', age: 5, adoptable: true)
    @pet_3 = @shelter.pets.create!(name: 'Chairman Meow', breed: 'cat', age: 1, adoptable: true)
    @applicant_1 = Application.create!(name: 'Steven', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "Pending"
      )
    @applicant_2 = Application.create!(name: 'Tyler', 
      street_address: '1234 main st.', 
      city: 'Westminster', 
      state: 'CO',
      zip_code: '80020', 
      reason_for_adoption: "I want the pig",
      status: "Pending"
      )
    PetApplication.create!(pet_id: @pet_1.id, application_id: @applicant_1.id, application_status: "Pending")
    PetApplication.create!(pet_id: @pet_1.id, application_id: @applicant_2.id, application_status: "Pending")
    PetApplication.create!(pet_id: @pet_2.id, application_id: @applicant_2.id, application_status: "Pending")
    PetApplication.create!(pet_id: @pet_3.id, application_id: @applicant_2.id, application_status: "Pending")
  end

  it "can approve pets for adoption" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Approve Application")

    click_button("Approve Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("Application Approved")
      expect(page).not_to have_button("Approve Application")
    end
  end

  it "can reject pets for adoption" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Reject Application")

    click_button("Reject Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("Application Rejected")
      expect(page).not_to have_button("Reject Application")
      expect(page).not_to have_button("Approve Application")
    end
  end

  it "doesn't approve or reject for all" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Approve Application")

    click_button("Reject Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("Application Rejected")
      expect(page).not_to have_button("Reject Application")
    end

    visit "/admin/applications/#{@applicant_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
    end
  end

  it "can show approved applications" do
    visit "/admin/applications/#{@applicant_2.id}"

    expect(page).to have_content("Status: Pending")

    within("#pet-#{@pet_1.id}") do
      click_button "Approve Application"
      expect(page).to have_content("Application Approved")
    end

    within("#pet-#{@pet_2.id}") do
      click_button "Approve Application"
      expect(page).to have_content("Application Approved")
    end

    within("#pet-#{@pet_3.id}") do
      click_button "Approve Application"
      expect(page).to have_content("Application Approved")
    end

    expect(page).to have_content("Status: Approved")
  end

  it "can show rejected applications" do
    visit "/admin/applications/#{@applicant_2.id}"

    expect(page).to have_content("Status: Pending")

    within("#pet-#{@pet_1.id}") do
      click_button "Approve Application"
      expect(page).to have_content("Application Approved")
    end

    within("#pet-#{@pet_2.id}") do
      click_button "Reject Application"
      expect(page).to have_content("Application Rejected")
    end

    within("#pet-#{@pet_3.id}") do
      click_button "Approve Application"
      expect(page).to have_content("Application Approved")
    end

    expect(page).to have_content("Status: Rejected")
  end

  it "application approval makes pets not adoptable" do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("true")
    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("true")
    visit "/pets/#{@pet_3.id}"
    expect(page).to have_content("true")

    visit "/admin/applications/#{@applicant_2.id}"

    within("#pet-#{@pet_1.id}") do
      click_button "Approve Application"
    end

    within("#pet-#{@pet_2.id}") do
      click_button "Approve Application"
    end

    within("#pet-#{@pet_3.id}") do
      click_button "Approve Application"
    end

    expect(page).to have_content("Status: Approved")

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("false")
    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("false")
    visit "/pets/#{@pet_3.id}"
    expect(page).to have_content("false")
  end

  it "cannot approve a pet that has already been approved" do
    visit "/admin/applications/#{@applicant_1.id}"

    click_button "Approve Application"

    visit "/admin/applications/#{@applicant_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("This pet has been approved for adoption")
      expect(page).not_to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
    end
  end
end