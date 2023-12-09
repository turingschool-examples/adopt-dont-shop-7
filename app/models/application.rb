class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :address,        presence: true
  validates :city,           presence: true
  validates :state,          presence: true
  validates :zip_code,       presence: true
  validates :description,    presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications
  
  def search_pets_by_name(name)
    Pet.search_by_name(name)
  end

  def adopt_pet(id)
    pet = Pet.find(id)
    self.pets << pet
  end
end