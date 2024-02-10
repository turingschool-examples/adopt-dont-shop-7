require 'rails_helper'

RSpec.describe Application, type: :model do
 describe 'relationships' do
  it { should have_many :application_pets }
  it { should have_many(:pets).through(:application_pets)}
 end

 describe 'instance methods' do
  it "returns an array of pet objects" do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @application_1 = Application.create!(name: "Selena", address: "123 Street City State Zip", adopting_reason: "Love for cats, no job", status:"Pending")
    @application_pets_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @application_pets_2 = ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    
    expect(@application_1.find_pets).to eq ([@pet_1, @pet_2])
  end
 end
end