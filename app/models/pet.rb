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
      if pets_adopted.include?(pet)
        pet.adoptable = false
        if pet.id == pet_id
          return pet
        end
      else
        pet.adoptable = true
        if pet.id == pet_id
          return pet
        end
      end
    end


    # require 'pry'; binding.pry
    # # require 'pry'; binding.pry
    # pets_up_for_adoption.each do |pet|
    #   # require 'pry'; binding.pry
    #   pet.adoptable = false
    #   if pet.id == pet_id
    #     return pet
    #   else
    #     require 'pry'; binding.pry
    #     pet.adoptable = true
    #     return pet
    #   end
    # end
    # # require 'pry'; binding.pry
  end
end
