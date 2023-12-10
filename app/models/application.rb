class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :status, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  def search_for_pet(search)
    @result = Pet.all.where("name ILIKE :search", search: "%#{search}")
  end
end
