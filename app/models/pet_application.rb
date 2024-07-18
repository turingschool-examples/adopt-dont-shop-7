class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates :pet_id, :application_id, presence: true

  def self.associated_applications(application)
    where(:application_id == application)
  end
end