require "rails_helper"

RSpec.describe Pet do
  describe 'approve' do
    it 'sets approved to true' do
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

      pet_1.approved
      expect(pet_1.reload.approved).to be true
    end
  end
end