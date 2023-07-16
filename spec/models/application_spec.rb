require "rails_helper"

RSpec.describe Application, type: :model do
  
  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  before(:each) do
    @mr_ape = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
    @paul = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "England", zip: "48", description: "I still believe love is all you need.  I don't know a better message than that.", status: "In Progress")
    @penny_lane = Application.create(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "California", zip: "90210", description: "Strawberry Fields Forever", status: "Pending")
    
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)

    @app_pet_1 = ApplicationPet.create!(application_id: @mr_ape.id, pet_id: @pet_1.id)
    @app_pet_2 = ApplicationPet.create!(application_id: @mr_ape.id, pet_id: @pet_2.id)
  end

  describe "instance methods" do
    describe ".pets?" do
      it "returns a booleans if an application has any pets" do
        expect(@mr_ape.pets?).to be true
        expect(@paul.pets?).to be false

        app2_pet = ApplicationPet.create!(application_id: @paul.id, pet_id: @pet_1.id)
        @paul.reload
        expect(@paul.pets?).to be true
      end
    end

    describe ".can_submit?" do
      it "returns a boolean if an application is 'In Progress' and has pets" do
        expect(@mr_ape.can_submit?).to be true
        expect(@paul.can_submit?).to be false
        expect(@penny_lane.can_submit?).to be false

        app2_pet = ApplicationPet.create!(application_id: @paul.id, pet_id: @pet_1.id)
        @paul.reload
        expect(@paul.can_submit?).to be true
      end
    end

  end
end

