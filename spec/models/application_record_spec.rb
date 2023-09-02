require "rails_helper"

RSpec.describe ApplicationRecord, type: :model do
  describe "search functions" do
    it "searches for pets in the database that are case insensitive and partial matches" do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create(name: "Bare-y Manilow", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "Bare-y J", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "fluffy", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "fluff", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "mr. fluff", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "Fluffy", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "FLUFF", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      
      pet = Pet.create(name: "Mr. Fluff", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)      

      ApplicationRecord.table_name = "pets"

      search = ApplicationRecord.search('Bare')
      expect(search.count).to eq(2)

      search = ApplicationRecord.search('fluff')
      expect(search.count).to eq(6)
      expect(search[0].name).to eq("fluffy")
      expect(search[1].name).to eq("fluff")
      expect(search[2].name).to eq("mr. fluff")
      expect(search[3].name).to eq("Fluffy")
      expect(search[4].name).to eq("FLUFF")
      expect(search[5].name).to eq("Mr. Fluff")      
    end
  end
end