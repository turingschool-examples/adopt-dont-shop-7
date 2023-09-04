class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates_inclusion_of :status, in: ["In Progress", "Pending", "Accepted", "Rejected"]

  def pet_names
    pets.pluck(:name)
  end

  def pet_link(pet_name)
    pet = Pet.find_by(name: pet_name)
    "/pets/#{pet.id}" if pet
  end
end