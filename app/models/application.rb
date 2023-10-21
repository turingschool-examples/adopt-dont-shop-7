class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  def address_join
    "#{street_address}, #{city}, #{state}, #{zip_code}"
  end

  def adopt
    ##For storing a pet into a specific application <<
  end
end