class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :description, presence: true
  validates :status, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def individual_pet_status(pet)
    pet_applications.find_by(pet_id: pet.id).status
  end
end