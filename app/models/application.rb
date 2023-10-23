class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_pet_by_name(name)
    Pet.find_by(name: name)
  end

end