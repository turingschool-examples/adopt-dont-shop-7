class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  validates :description, presence: true

  def add_pet_to_application(pet_id)
    pet = Pet.find(pet_id)
    self.pets << pet
  end

  def change_application_status(new_status)
    self.update(status: new_status)
  end
end