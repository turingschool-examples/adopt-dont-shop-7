require 'rails_helper'

RSpec.describe "Admin Applications Show Page" do
  before(:each) do
    # Shelters
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    
    # Pets
    @lucille = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "Sphynx", name: "Lucille Bald")
    @scooby = @shelter_2.pets.create!(adoptable: true, age: 2, breed: "Great Dane", name: "Scooby")
    @whiskers = @shelter_1.pets.create!(adoptable: true, age: 5, breed: "Kitty", name: "Whiskers")
    @clifford = @shelter_2.pets.create!(adoptable: true, age: 2, breed: "Big Red Dog", name: "Clifford")
  
    # Applications
    @paul_app_1 = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "UK", zip: "48J77", description: "I still believe love is all you need.  I don't know a better message than that.", status: "Pending")
    @paul_app_2 = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "UK", zip: "48J77", description: "I still believe love is all you need.  I don't know a better message than that.", status: "Pending")
    @penny_lane_app_1 = Application.create!(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "CA", zip: "90210", description: "Strawberry Fields Forever", status: "Pending")
    @penny_lane_app_2 = Application.create!(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "CA", zip: "90210", description: "Strawberry Fields Forever", status: "Pending")
    
    # ApplicationPets
    @paul_pet_1 = ApplicationPet.create!(application_id: @paul_app_1.id, pet_id: @lucille.id, status: "Approved")
    @paul_pet_2 = ApplicationPet.create!(application_id: @paul_app_2.id, pet_id: @scooby.id, status: "Rejected")
    @penny_lane_pet_1 = ApplicationPet.create!(application_id: @penny_lane_app_1.id, pet_id: @whiskers.id, status: "Approved")
    @penny_lane_pet_2 = ApplicationPet.create!(application_id: @penny_lane_app_2.id, pet_id: @clifford.id, status: "Rejected")
  end
  

  describe "As a visitor" do
    context "accepted applications" do
      describe "when I visit an admin application show page" do
        it "for every pet that the application is for, I see a button to approve the applicaiton for that specific pet" do
          visit "/admin/applications/#{@paul_app_1.id}"


        end

        xit "when I click that button it links back to the admin application show page" do
          visit "/admin/applications/#{@penny_lane_app_1.id}"

        end

        xit "and next to the pet that I approved, I do not see a button to approve this pet but do see an indicator that they have been approved" do
          visit "/admin/applications/#{@paul_app_1.id}"

        end
      end
    end

    # context "rejected applications" do
    #   describe "when I visit an admin application show page" do
    #     xit "for every pet that the application is for, I see a button to reject the applicaiton for that specific pet" do
    #       visit "/admin/applications/#{@paul_app_2.id}"

    #     end
        
    #     xit "when I click that button it links back to the admin application show page" do
    #       visit "/admin/applications/#{@penny_lane_app_2.id}"

    #     end
 
    #     xit "and next to the pet that I rejected, I do not see a button to approve this pet but do see an indicator that they have been approved" do
    #       visit "/admin/applications/#{@paul_app_2.id}"

    #     end
    #   end
    # end
  end
end