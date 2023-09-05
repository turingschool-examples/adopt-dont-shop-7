class PetApplication < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true
  validates :status, presence: true
  belongs_to :application
  belongs_to :pet

  def self.find_relevant_application(application_id, pet_id )
    where(application_id: application_id, pet_id: pet_id ).first
  end
end