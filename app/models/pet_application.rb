class PetApplication < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true
  validates :status, presence: true
  belongs_to :application
  belongs_to :pet
end