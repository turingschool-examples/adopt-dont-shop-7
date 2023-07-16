class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name_of_applicant, :street_address, :city, :state, :zip_code, :description, presence: true
  validates :name_of_applicant, presence: { message: "Please provide the name of the applicant." }
  validates :street_address, presence: { message: "Please provide the street address." }
  validates :city, presence: { message: "Please provide the city." }
  validates :state, presence: { message: "Please provide the state." }
  validates :zip_code, presence: { message: "Please provide the zip code." }
  validates :description, presence: { message: "Please provide a description." }


end
