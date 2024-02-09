class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { in_progress: 0, pending: 1, accepted: 2, rejected: 3 }
  def full_address
    street_address << " " << city << ", " << state << " " << zipcode
  end

  def added_pets?
    self.pets.present?
  end

  def all_pets_approved
    if status_of_application_pet.uniq.count == 1 && status_of_application_pet.first
      true
    elsif status_of_application_pet.include?(nil)
      nil
    else
      false
    end
  end

  def status_of_application_pet
    application_pets.pluck(:application_approved)
  end

end
