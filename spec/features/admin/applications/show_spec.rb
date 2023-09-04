require "rails_helper"

RSpec.describe "Admin show" do
  before :each do
    @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
    @pet = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
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
    PetApplication.create!(pet_id: @pet.id, application_id: @applicant_1.id)
    PetApplication.create!(pet_id: @pet.id, application_id: @applicant_2.id)
  end

  it "can approve pets for adoption" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Approve Application")

    click_button("Approve Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet.id}") do
      expect(page).to have_content("Application Approved")
      expect(page).not_to have_button("Approve Application")
    end
  end

  it "can reject pets for adoption" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Reject Application")

    click_button("Reject Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet.id}") do
      expect(page).to have_content("Application Rejected")
      expect(page).not_to have_button("Reject Application")
      expect(page).not_to have_button("Approve Application")
    end
  end

  it "doesn't approve or reject for all" do
    visit "/admin/applications/#{@applicant_1.id}"

    expect(page).to have_button("Approve Application")

    click_button("Approve Application")

    expect(current_path).to eq("/admin/applications/#{@applicant_1.id}")
    
    within("#pet-#{@pet.id}") do
      expect(page).to have_content("Application Approved")
      expect(page).not_to have_button("Approve Application")
    end

    visit "/admin/applications/#{@applicant_2.id}"

    within("#pet-#{@pet.id}") do
      expect(page).to have_button("Approve Application")
      expect(page).to have_button("Reject Application")
    end
  end
end