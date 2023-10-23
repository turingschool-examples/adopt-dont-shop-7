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

  def self.update_adoptable
    # pets_up_for_adoption = self.joins([{application_pets: :application}]).where("application.status == 'Approved'").distinct.pluck("pets")
    # require 'pry'; binding.pry
    # pets_up_for_adoption.each do |pet|
    #   pet[:adoptable] = false
    # end
    # pets_up_for_adoption
  end
end
