class PetApplication < ApplicationRecord
  validates :pet_id, uniqueness: { scope: :application_id, message: "A pet can only be adopted once" }, presence: true
  validates :application_id, presence: true
  
  belongs_to :application, dependent: :destroy
  belongs_to :pet, dependent: :destroy
end