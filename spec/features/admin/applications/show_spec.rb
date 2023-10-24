require 'rails_helper'

RSpec.describe "Admin Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter_1.id)
    @pet_4 = @shelter_1.pets.create(adoptable: true, age: 5, breed: "catahoula", name: "Chispa", shelter_id: @shelter_1.id)
    @pet_5 = @shelter_1.pets.create(adoptable: true, age: 9, breed: "chihuahua", name: "Tiny", shelter_id: @shelter_1.id)

    @application = Application.create!(name: "Stacy Chapman", street_address: "1870 Canopy Rd", city: "Los Angeles", state: "CA", zip_code: 90001, description: "I grew up with dachshunds and felt really connected", status: "In Progress")
  end

  describe '#initialize' do
    it 'exists' do
      @application.pets << @pet_3
      @application.pets <<@pet_5
      visit "/admin/applications/#{@application.id}"
      save_and_open_page
    end
  end
end