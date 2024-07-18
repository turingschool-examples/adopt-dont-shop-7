class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name, :street_address, :city, :state, :zip_code, :description, presence: true

  def has_pets?
    self.pets.count >= 1
  end
end

