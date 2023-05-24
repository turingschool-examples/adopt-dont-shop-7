class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.find_shelter_applications
    require 'pry'; binding.pry
    joins(pet: [:shelter])
    
  end

end