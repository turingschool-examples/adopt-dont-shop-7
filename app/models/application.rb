class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true

  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}

  def full_address
    "#{self.street_address}, #{self.state}, #{self.city}, #{self.zip_code}"
  end

  def add_pet(pet)
    pets << pet
  end

  def approve_pet(pet)
    status = "Approved"
    pet.adoptable = false
  end

  def approved
    status == "Approved"
  end

  def rejected
   status == "Rejected"
  end

  def reject_pet(pet)
    self.status = "Rejected"
  end
end