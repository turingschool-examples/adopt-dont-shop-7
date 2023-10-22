class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :pet_id, uniqueness: {scope: :application_id, message: "and Application combination must be unique"}
end
