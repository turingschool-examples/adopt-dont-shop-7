class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: :true, inclusion: {in: ["In Progress", "Accepted", "Rejected", "Pending"]}

  def search_pets_by_name(pet_name)
    return [] unless pet_name.present?

    Pet.where("name ILIKE ?", "%#{pet_name}%")
  end
end
