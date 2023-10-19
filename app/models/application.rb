class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def address_join
    "#{street_address}, #{city}, #{state}, #{zip_code}"
  end
end