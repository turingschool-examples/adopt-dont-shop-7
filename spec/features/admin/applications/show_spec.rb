require "rails_helper"

RSpec.describe "the admin application show" do
  before :each do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet = @shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(name: "Scrappy", age: 1, breed: "Good Dane", adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
    @application_2 = Application.create!(name: "Papa John", street_address: "222 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
  end

  describe "I visit an admin application show page ('/admin/applications/:id')" do
    describe "For every pet that the application is for, I see a button to approve the application for that specific pet" do
      describe "I click that button and I'm taken back to the admin application show page" do
        it " next to the pet that I approved, I do not see a button to approve this pet and instead I see an indicator next to the pet that they have been approved" do
          @application.pets << [@pet, @pet_2]
          visit("/admin/applications/#{@application.id}")
          expect(page).to have_button("Approve #{@pet.name}")
          expect(page).to have_button("Approve #{@pet_2.name}")

          click_button("Approve #{@pet.name}")

          expect(page).to have_no_button("Approve #{@pet.name}")
          expect(page).to have_content("#{@pet.name} has been approved")
          expect(page).to have_button("Approve #{@pet_2.name}")
        end
      end
    end
  end

  describe "I visit an admin application show page ('/admin/applications/:id')" do
    describe "For every pet that the application is for, I see a button to reject the application for that specific pet" do
      describe "I click that button and I'm taken back to the admin application show page" do
        it " next to the pet that I rejected, I do not see a button to reject this pet and instead I see an indicator next to the pet that they have been rejected" do
          @application.pets << [@pet, @pet_2]
          visit("/admin/applications/#{@application.id}")
          expect(page).to have_button("Reject #{@pet_2.name}")
          expect(page).to have_button("Reject #{@pet.name}")

          click_button("Reject #{@pet_2.name}")

          expect(page).to have_no_button("Reject #{@pet_2.name}")
          expect(page).to have_content("#{@pet_2.name} has been rejected")
          expect(page).to have_button("Approve #{@pet.name}")
        end
      end
    end
  end

  describe "When there are two applications in the system for the same pet" do
    describe "When I visit the admin application show page for one of the applications and I approve or reject the pet for that application" do
      describe "I visit the other application's admin show page" do
        it "I do not see that the pet has been accepted or rejected for that application and instead I see buttons to approve or reject the pet for this specific application" do
          @application.pets << [@pet, @pet_2]
          @application_2.pets << [@pet, @pet_2]
          visit("/admin/applications/#{@application.id}")
          expect(page).to have_button("Approve #{@pet.name}")
          expect(page).to have_button("Approve #{@pet_2.name}")

          click_button("Approve #{@pet.name}")

          expect(page).to have_content("#{@pet.name} has been approved")

          visit("/admin/applications/#{@application_2.id}")

          expect(page).to have_button("Approve #{@pet.name}")
          expect(page).to have_button("Reject #{@pet.name}")
        end
      end
    end
  end
end
