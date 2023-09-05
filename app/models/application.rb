class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :applicant_name, :street_address, 
          :city, :state, :zip_code, :description, :status 
end