require 'rails_helper'

RSpec.describe "Admin Applications Show" do
  before(:each) do
    @application_1 = Application.create!(name: "Tyler Blackmon", address: "1234 Test St, Colorado Springs, CO, 80922", description: "This is why I'd be a good home!", status: "In Progress")
    @application_2 = Application.create!(name: "Josh Blackmon", address: "4321 Another Test St, Colorado Springs, CO, 80922", description: "My description is too good", status: "In Progress")
    @shelter_1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet_1 = @application_1.pets.create!(name: "Scooby", age: 2, breed: "Greate Dane", adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = @application_1.pets.create!(name: "Chicken", age: 6, breed: "Actually A Bird", adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = @application_2.pets.create!(name: "Kiwi", age: 5, breed: "Actually A Kiwi", adoptable: true, shelter_id: @shelter_1.id)
  end

  describe "When I visit /admin/applications/:id" do
    it "For every pet on the application, I see an approval button for that pet" do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.description)

      within("#pet-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_1.age)
        expect(page).to have_content(@pet_1.breed)
        expect(page).to have_content(@pet_1.shelter_id)
        expect(page).to have_button("Approve Pet")
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_2.age)
        expect(page).to have_content(@pet_2.breed)
        expect(page).to have_content(@pet_2.shelter_id)
        expect(page).to have_button("Approve Pet")
      end
    end

    it "When I click the approval button, I'm redirected to the same page and the pet is shown as approved" do
      visit "/admin/applications/#{@application_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_button("Approve Pet")
      end

      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")

      within("#pet-#{@pet_1.id}") do
        expect(page).to_not have_button("Approve Pet")
        expect(page).to have_content("Pet status: Approved")
      end
    end
  end
end