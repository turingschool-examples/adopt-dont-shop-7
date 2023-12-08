class Application < ApplicationRecord
  validates :applicant_name, :address, :city, :state, :zip_code, :description, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end