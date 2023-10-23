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

  def self.update_adoptable(application_id)
    pets = Pet.all
    pets_adopted = Pet.joins(:application_pets).where("application_pets.application_id = #{application_id}").distinct
    # require 'pry'; binding.pry
    pets_adopted.each do |pet|
      pet.adoptable = false
    end
    # require 'pry'; binding.pry
  end
end
