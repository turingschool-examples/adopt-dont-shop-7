class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true

  def full_address
    "#{self.street_address}, #{self.state}, #{self.city}, #{self.zip_code}"
  end

  def search_for_pet(params)
    pets = Pet.all
    pets.where(name: params[:search])
  end
end