class AdoptionApplication < ApplicationRecord
   has_many :adoption_application_pets
   has_many :pets, through: :adoption_application_pets
   validates :name, :street_address, :city, :state, :zip_code, :description, :status, presence: true
end