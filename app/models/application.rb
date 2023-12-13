class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true
  has_many :application_pets


  def self.application(id)
    Application.find(id)
  end

  def self.approve_or_deny_application_pet(pet_id, application_id, filter)
    application_pet_id = ApplicationPet.where(pet_id: pet_id, application_id: application_id).pluck(:id).first
    application_pet = ApplicationPet.find(application_pet_id)
    application_pet.approve_or_deny(filter)
  end

  def full_address
    street_address << " " << city << ", " << state << " " << zipcode
  end

  def list_of_pets
    pet_ids = application_pets.where("application_id = ?", self.id).pluck(:pet_id)
    Pet.where(id: pet_ids)
  end

  def set_status_in_progress
    self.status = "In Progress"
    self.save
  end

  def find_pet(name)
    Pet.where("name ILIKE ?", "%#{name}%")
  end

  def added_pets?
    list_of_pets.present?
  end

  def all_pets_approved
    if status_of_application_pet.uniq.count == 1 && status_of_application_pet.first == true
      true
    elsif status_of_application_pet.include?(nil)
      nil
    else
      false
    end
  end

  def status_of_application_pet
    self.application_pets.pluck(:application_approved)
  end

end
