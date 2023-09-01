class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates_presence_of :applicant_name
  validates_presence_of :full_address
  validates_presence_of :application_status
  validates_presence_of :description
end