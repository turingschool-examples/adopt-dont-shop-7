class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true
  validates :status, presence: true
end
