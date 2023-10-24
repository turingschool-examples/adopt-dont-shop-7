require "rails_helper"

RSpec.describe "the admin application show" do
  before :each do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet = @shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(name: "Scrappy", age: 1, breed: "Good Dane", adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(name: "Jimmy John", street_address: "111 lonely road", city: "John City", state: "AR", zip_code: "90909", description: "I like animals", status: "In Progress")
  end

  describe "I visit an admin application show page ('/admin/applications/:id')" do 
    describe "For every pet that the application is for, I see a button to approve the application for that specific pet" do 
      describe "I click that button and I'm taken back to the admin application show page" do 
        it " next to the pet that I approved, I do not see a button to approve this pet and instead I see an indicator next to the pet that they have been approved" do 
          @application.pets << [@pet, @pet_2]
          visit ("/admin/applications/#{@application.id}")
          

          expect(page).to have_button("Approve #{@pet.name}") 
          expect(page).to have_button("Approve #{@pet_2.name}")

          click_button("Approve #{@pet.name}")
save_and_open_page
          expect(page).to have_no_button("Approve #{@pet.name}")
          expect(page).to have_content("#{@pet.name} has been approved")
          expect(page).to have_button("Approve #{@pet_2.name}")

        end
      end
    end
  end
end