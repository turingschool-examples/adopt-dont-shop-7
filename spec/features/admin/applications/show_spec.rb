require "rails_helper"

RSpec.describe "Admin Application Show Page" do
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

    @petapplication_1 = PetApplication.create!(application_id: @application.id, pet_id: @pet_1.id)
    @petapplication_2 = PetApplication.create!(application_id: @application.id, pet_id: @pet_2.id)

    visit "/admin/applications/#{@application.id}"
  end

  it "can show all the applications" do
    @application.pets.each do |pet|
      within "#pending_pets-#{pet.id}" do
        expect(page).to have_content(pet.name)
        expect(page).to have_button("Approve")
      end
    end
    within "#pending_pets-#{@pet_1.id}" do
      click_button "Approve"
      expect(current_path).to eq("/admin/applications/#{@application.id}")
    end
    # save_and_open_page
    within "#pending_pets-#{@pet_1.id}" do
      expect(page).to_not have_button("Approve")
      expect(page).to have_content("Approved")
    end
  end
end
