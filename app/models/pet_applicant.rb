class PetApplicant < ApplicationRecord
  validates :pet_id, presence: true, numericality: true
  validates :applicant_id, presence: true, numericality: true

  belongs_to :pet, optional: true 
  belongs_to :applicant
end