class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.matching_applications(application)
    where(application: application.id)
  end
end