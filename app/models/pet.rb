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
    pets_up_for_adoption = Pet.joins([{application_pets: :application}]).where("applications.status = 'Approved'").distinct
    # require 'pry'; binding.pry
    pets_up_for_adoption.each do |pet|
      # require 'pry'; binding.pry
      pet.adoptable = false
      if pet.id == pet_id
        return pet
      else
        pet.adoptable = true
        return pet
      end
    end
    # require 'pry'; binding.pry
  end
end
