class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_applications(application)
    where("application_id = #{application}")
  end
end