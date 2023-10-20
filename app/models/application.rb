class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def full_address
    "#{address}, #{city}, #{state}, #{zip}"
  end

  def pet_names
    pets.pluck(:name)
  end
end
