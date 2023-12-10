require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  it "has a method to search for a pet by name" do
    application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "In Progress")
    shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet1 = shelter.pets.create!(name: "garfield", breed: "shorthair", adoptable: true, age: 1)

    result = application1.search_for_pet("garfield")

    expect(result).to include(pet1)
  end
end
