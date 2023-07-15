class Application < ApplicationRecord 
  validates :street_address, :city, :state, :zip_code, :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets
end