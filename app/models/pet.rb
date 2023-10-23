class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.update_adoptable(pet_id)
    pets = Pet.all
    pets_adopted = Pet.joins([{application_pets: :application}]).where("applications.status = 'Approved'").distinct

    pets.each do |pet|
      if pets_adopted.include?(pet) && pet.id == pet_id
        pet.adoptable = false
        return pet
      else
        pet.adoptable = true
        return pet
      end
    end
  end
end
