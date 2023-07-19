class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates :pet_id, presence: true, numericality: true
  validates :application_id, presence: true, numericality: true
  validates :approved, presence: true
end