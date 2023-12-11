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

  # would it make sense to refactor these into one "status" method or leave as smaller separate methods? Could see pros and cons to both...
  ## Yes, took away set_status_pending, I did that in the Controller's #update
  def set_status_in_progress
    self.status = "In Progress"
  end

  def find_pet(name)
    Pet.where("name ILIKE ?", "%#{name}%")
  end

  def added_pets?
    list_of_pets.present?
  end
end
