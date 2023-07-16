class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates :application_id, uniqueness: { scope: :pet_id, message: "already has that pet." }
end
