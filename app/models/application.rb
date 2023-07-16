class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street, :city, :state, :zip, :description, presence: true
  validates :zip, length: { is: 5 }
  validates :state, format: { with: /[A-Z]{2}/, message: "Please use 2 capital letters for the state abbreviation" }
end