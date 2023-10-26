class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :description, presence: true
  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
  validates :zip_code, presence: true, numericality: true, length: {minimum: 5, maximum: 5}

  def full_address
    "#{self.street_address}, #{self.city}, #{self.state} #{self.zip_code}"
  end

  def add_pet(pet)
    application_pets << pet
  end

  def rejected_pets
    application_pets.where(application_pet_status: 3).present?
  end
end