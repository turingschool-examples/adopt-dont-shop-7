require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "#searched_pet" do
    before :each do
      @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
      @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
      @pet_4 = Pet.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter.id)
      @pet_5 = Pet.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter.id)
      @pet_6 = Pet.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter.id)
    end

    it "will find partial matches for a pets name" do
      params = {:search => "Mr"}
      expect(Application.searched_pet(params)).to eq([@pet_4])
      params = {:search => "Claw"}
      expect(Application.searched_pet(params)).to eq([@pet_5])
      params = {:search => "le Ba"}
      expect(Application.searched_pet(params)).to eq([@pet_1])
    end

    it "Is case insensitive for pet searches" do
      params = {:search => "mr. pirate"}
      expect(Application.searched_pet(params)).to eq([@pet_4])
      params = {:search => "cLawdia"}
      expect(Application.searched_pet(params)).to eq([@pet_5])
      params = {:search => "LUCILLE BALD"}
      expect(Application.searched_pet(params)).to eq([@pet_1])
    end

    it "Checks if an application has_pets?" do
      application = Application.create!(name: "Eric", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending")
      expect(application.has_pets?).to be false
      application.pets << @pet_1
      expect(application.has_pets?).to be true
    end
  end

  describe '#Application creation with missing params' do
    before :each do
      @application = Application.create!(name: "", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending")
    end
    it "Will create a full test" do
      params = {name: "Eric", street_address: "9999 Street Road", city: "Denver", state: "CO", zip_code: "80231", good_home: "Gimme", good_owner: "I like cats", status: "Pending"}
      expect(Application.create_full_address(params)).to eq("9999 Street Road, Denver, CO, 80231")

      # If left blank the field will be left empty
      params = {name: "Eric", street_address: "9999 Street Road", city: "Denver", state: "CO", good_home: "Gimme", good_owner: "I like cats", status: "Pending"}
      expect(Application.create_full_address(params)).to eq("9999 Street Road, Denver, CO, ")
    end

    it 'Will return field with empty params' do
      # Will give a link and error message to which field is empty
      params = {name: "", full_address: "123 Test St", good_home: "I like fish"}
      expect(Application.empty_params_link(params)).to eq("/applications/new?name=true")
      # Will redirect to the page that you'ree supposed to go to without errors
      params = {name: "Eric", full_address: "123 Test St", good_home: "I like fish"}
      expect(Application.empty_params_link(params)).to eq("/applications/new")
      # give multiple errors in the link for which fields are empty.
      params = {name: "", full_address: "", good_home: ""}
      expect(Application.empty_params_link(params)).to eq("/applications/new?name=true&full_address=true&good_home=true")
    end
  end

  describe '#Approvals and rejections' do
    before :each do
      @application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "I like cats", status: "Approved")
      @application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I like fish", status: "Rejected")

      @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

      @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @pet_2 = @shelter_3.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      @pet_4 = @shelter_3.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
      @pet_5 = @shelter_3.pets.create(name: "QWERTY", breed: "sphynx", age: 8, adoptable: true)
      @pet_6 = @shelter_3.pets.create(name: "Ballistic Missile", breed: "sphynx", age: 8, adoptable: true)
      
      @application1.pets << @pet_1
      @application2.pets << @pet_2
    end

    it 'find_approvals' do
      ApplicationPet.where("pet_id = '#{@pet_1.id}' and application_id = '#{@application1.id}'").first.update(approved: true)
      expect(@application1.find_approvals).to eq([@pet_1.id])
      
      @application1.pets << @pet_2
      ApplicationPet.where("pet_id = '#{@pet_2.id}' and application_id = '#{@application1.id}'").first.update(approved: true)
      expect(@application1.find_approvals).to eq([@pet_1.id, @pet_2.id])
      
      expect(@application2.find_approvals).to eq([])
    end

    it "find_rejections" do
      ApplicationPet.where("pet_id = '#{@pet_1.id}' and application_id = '#{@application1.id}'").first.update(rejected: true)
      expect(@application1.find_rejections).to eq([@pet_1.id])
      
      @application1.pets << @pet_2
      ApplicationPet.where("pet_id = '#{@pet_2.id}' and application_id = '#{@application1.id}'").first.update(rejected: true)
      expect(@application1.find_rejections).to eq([@pet_1.id, @pet_2.id])
      
      expect(@application2.find_rejections).to eq([])
    end
  end

end