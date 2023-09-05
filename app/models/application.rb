class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates_inclusion_of :status, in: ["In Progress", "Pending", "Accepted", "Rejected"]

  def get_pets
    pets
  end
  
  def pet_names
    pets.pluck(:name)
  end

  def pet_link(pet_name)
    pet = Pet.find_by(name: pet_name)
    "/pets/#{pet.id}" if pet
  end

  def add_pet(pet_id)
    pet = Pet.find(pet_id)

    self.pets << pet
  end
end