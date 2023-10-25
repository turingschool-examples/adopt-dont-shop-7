class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :description, presence: true
  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
  validates :zip_code, presence: true, numericality: true, length: {minimum: 5, maximum: 5}

  def full_address
    "#{self.street_address}, #{self.state}, #{self.city}, #{self.zip_code}"
  end

  def add_pet(pet)
    pets << pet
  end
end