require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
  it { should have_many(:pets).through(:pet_applications) }
  end

  it "#add_pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    application = Application.create(name:"Bob", address:"SF", city: "Town", state: "Colorado", zip: "12345", description: "Fuzzy", status: "In Progress")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
  
    application.add_pet(pet_2.id)
    expect(application.pets).to eq([pet_2])
  end
end