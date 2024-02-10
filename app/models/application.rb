class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.num_of_applications
    self.count
  end
  
  def populate_address
    street_address+", "+city+", "+state+", "+(zip_code.to_s)
  end

  def find_pets
    self.pets
  end
end