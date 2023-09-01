class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  validates :application_id, presence: true
  validates :pet_id, presence: true
  validates :status, presence: true
end