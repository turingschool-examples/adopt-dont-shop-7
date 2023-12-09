require "rails_helper"

RSpec.describe "Admin Show page" do

  before(:each) do 
    @application = Application.create!(name: 'Taylor', street_address: '123 Side St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'In Progress')
    @application_2 = Application.create!(name: 'John', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'Pending')
    @application_3 = Application.create!(name: 'Jane', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'Pending')

    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
    @shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)

    @bella = @shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) 
    @rigby = @shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) 
    @luna = @shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) 
    @jimmy = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @pa_1 = PetApplication.create!(pet: @bella, application: @application, status: "Pending")
    @pa_2 = PetApplication.create!(pet: @rigby, application: @application, status: "In Progress")
    @pa_3 = PetApplication.create!(pet: @luna, application: @application, status: "In Progress")
    @pa_4 = PetApplication.create!(pet: @jimmy, application: @application_2, status: "Pending")
    @pa_5 = PetApplication.create!(pet: @jimmy, application: @application_3, status: "Rejected")
  end

  describe "Approving a pet for adoption" do
    it "there is an 'approve' button to approve the application for that specific pet" do

      visit "/admin/applications/#{@application.id}"

      within("#approve-#{@bella.id}") do
        expect(page).to have_content("Bella")
        expect(page).to have_button("Approve")

        click_button "Approve"

        expect(current_path).to eq("/admin/applications/#{@application.id}")
        
        expect(page).to have_content("Bella")
        expect(page).to_not have_button("Approve")
        
      end
    end
  end
end 