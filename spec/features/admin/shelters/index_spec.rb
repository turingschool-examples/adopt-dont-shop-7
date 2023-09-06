require 'rails_helper'

RSpec.describe "Shelters sort pending apps" do
    before :each do
      @shelter = Shelter.create!(name: 'Boulder Valley', city: 'Boulder', foster_program: false, rank: 15)
      @shelter_2 = Shelter.create!(name: 'Dylans Ranch', city: 'Erie', foster_program: false, rank: 15)
      @pet_1 = @shelter.pets.create!(name: 'Hank', breed: 'mini pig', age: 3, adoptable: true)
      @pet_2 = @shelter.pets.create!(name: 'Buddy', breed: 'gorilla', age: 5, adoptable: true)
      @pet_3 = @shelter_2.pets.create!(name: 'Chairman Meow', breed: 'cat', age: 1, adoptable: true)
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

      visit "/admin/shelters"
    end

    it "list shelters with pending applications alphabetically" do
        within('#shelters_with_pending_apps') do
          expect("Boulder Valley").to appear_before("Dylans Ranch")
        end
    end
end