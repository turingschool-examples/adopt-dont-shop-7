class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip_code, :description
  has_many :pets_applications
  has_many :pets, through: :pets_applications
end