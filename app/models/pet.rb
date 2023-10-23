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
    pets_up_for_adoption = self.left_joins([{application_pets: :application}]).where("applications.status != 'Accepted'").distinct
    # require 'pry'; binding.pry
    pets_up_for_adoption.each do |pet|
      pet[:adoptable] = true
    end
    pets_up_for_adoption
    # where(adoptable: true)
  end
end
