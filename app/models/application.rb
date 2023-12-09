class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true
  has_many :application_pets

  def full_address
    street_address << " " << city << ", " << state << " " << zipcode
  end

  def list_of_pets
    pet_ids = application_pets.where("application_id = ?", self.id).pluck(:pet_id)
    Pet.where(id: pet_ids)
  end

  def set_status_in_progress
    self.status = "In Progress"
  end

  def find_pet(name)
    Pet.joins(application_pets: :application).where(name: name).pluck(:name)
  end

end
