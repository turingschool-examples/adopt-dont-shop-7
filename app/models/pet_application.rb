class PetApplication < ApplicationRecord
  validates :pet_id, uniqueness: { scope: :application_id, message: "A pet can only be adopted once" }, presence: true
  validates :application_id, presence: true
  
  belongs_to :application
  belongs_to :pet
end