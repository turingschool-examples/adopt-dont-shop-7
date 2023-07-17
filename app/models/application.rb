class Application < ApplicationRecord 
  validates :street_address, :city, :state, :zip_code, :description, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
end