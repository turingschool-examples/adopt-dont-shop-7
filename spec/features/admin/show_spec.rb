require "rails_helper"

RSpec.feature "Admin Application Show", type: :feature do
  before(:each) do
    @shelter = Shelter.create!(
      foster_program: true,
      name: "The Shelter",
      city: "Happy City",
      rank: 1
    )

    @pet_1 = @shelter.pets.create!(
      adoptable: true,
      age: 7,
      breed: "sphynx",
      name: "Bare-y Manilow",
    )

    @pet_2 = @shelter.pets.create!(
      adoptable: true,
      age: 3,
      breed: "domestic pig",
      name: "Babe",
    )

    @pet_3 = @shelter.pets.create!(
      adoptable: true,
      age: 4,
      breed: "chihuahua",
      name: "Elle",
    )
    @application_1 = Application.create!(
      name: "John Smith",
      street_address: "1234 Lane Street",
      city: "Happy City",
      state: "CO",
      zip_code: "80111",
      owner_description: "I want an animal",
      status: "Pending"
    )
    @application_2 = Application.create!(
      name: "Jill Lane",
      street_address: "3462 Cat Avenue",
      city: "Cat City",
      state: "CO",
      zip_code: "80111",
      owner_description: "I have fostered before.",
      status: "Pending"
    )
  end
  describe "When I visit an admin application show page, for every pet that the application is for, I see a button to approve the application for that specific pet" do
    describe "When I click that button then I'm taken back to the admin application show page" do
      it "Next to the pet that I approved, I do not see a button to approve this pet instead I see an indicator next to the pet that they have been approved" do
        @application_1.pets << [@pet_1, @pet_2, @pet_3]

        visit "/admin/applications/#{@application_1.id}"

        @application_1.pets.each do |pet|
          expect(page).to have_button("Approve #{pet.name}")
          click_button("Approve #{pet.name}")

          expect(page).to have_no_button("Approve #{pet.name}")
          expect(page).to have_content("#{pet.name} has been approved")
        end
      end
    end
  end

  describe "When I visit an admin application show page, for every pet that the application is for, I see a button to reject the application for that specific pet" do
    describe "When I click that button then I'm taken back to the admin application show page" do
      it "Next to the pet that I rejected, I do not see a button to reject this pet instead I see an indicator next to the pet that they have been rejected" do
        @application_1.pets << [@pet_1, @pet_2, @pet_3]

        visit "/admin/applications/#{@application_1.id}"

        @application_1.pets.each do |pet|
          expect(page).to have_button("Reject #{pet.name}")
          click_button("Reject #{pet.name}")

          expect(page).to have_no_button("Reject #{pet.name}")
          expect(page).to have_content("#{pet.name} has been rejected")
        end
      end
    end
  end

  describe "as a visitor" do
    describe "when there are two applications in the system for the same pet" do
      describe "when I visit the admin application show page for one of the applications and I approve or reject the pet for that application" do
        describe "when I visit the other application's admin page" do
          it "Then I do not see that the pet has been accepted or rejected for that application and instead I see buttons to approve or reject hte pet for this specific application" do
            @application_1.pets << @pet_1
            @application_2.pets << @pet_1

            visit "/admin/applications/#{@application_1.id}"

            click_button("Approve #{@pet_1.name}")

            visit "/admin/applications/#{@application_2.id}"

            expect(page).to have_button("Approve #{@pet_1.name}")
          end
        end
      end
    end
  end
end
