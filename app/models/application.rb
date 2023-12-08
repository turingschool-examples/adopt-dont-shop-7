class Application < ApplicationRecord
has_many :application_pets

  def full_address
    street_address << " " << city << ", " << state << " " << zipcode
  end

  def list_of_pets
    pet_ids = application_pets.select(:pet_id).where("application_id = ?", self.id).pluck(:pet_id)
    Pet.where(id: pet_ids)
  end

  def set_status_in_progress
    self.status = "In Progress"
  end

end
