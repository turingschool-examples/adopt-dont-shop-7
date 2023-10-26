require "rails_helper"

RSpec.describe Application do
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets) }
  end

  before(:each) do
    @app1 = Application.create!(name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
      description: "Good home for good boy", status: "In Progress")
    @app2 = Application.create!(name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
      description: "Good home for good boy", status: "In Progress")
    @s1 = Shelter.create!(foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2)
    @p1 = Pet.create!(name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id)
    @p2 = Pet.create!(name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id)
    @pa1 = PetApplication.create!(application: @app1, pet: @p2)
    PetApplication.create!(application: @app2, pet: @p1)
  end

  describe "instance methods" do
    describe "#full_address" do
      it "combines address attributes to single string" do
        expect(@app2.full_address).to eq "1080 Pronghorn, Del Norte, CO, 81132"
      end
    end

    describe "#pet_names" do
      it "returns array of all the pets on the application" do
        expect(@app2.pet_names).to eq [@p1.name]
      end
    end

    describe "#pet_status" do
      it "gets the status of all pets on the application" do
        expect(@app1.pet_status).to eq({@p2.id => @pa1.status})

        @app1.pet_applications.create!(pet_id: @p1.id, status: "Approved")

        expect(@app1.pet_status).to eq({@p2.id => @pa1.status, @p1.id => "Approved"})
      end
    end

    describe "#pet_approved" do
      it "returns boolean for if a pet and application combo is approved or not" do
        @app1.pet_applications.create!(pet_id: @p1.id, status: "Approved")

        expect(@app1.pet_approved(@p1.id)).to eq true
        expect(@app1.pet_approved(@p2.id)).to eq false
      end
    end

    describe "#pet_rejected" do
      it "returns boolean for if a pet and application combo is rejected or not" do
        @app1.pet_applications.create!(pet_id: @p1.id, status: "Rejected")

        expect(@app1.pet_rejected(@p1.id)).to eq true
        expect(@app1.pet_approved(@p2.id)).to eq false
      end
    end

  end
end
