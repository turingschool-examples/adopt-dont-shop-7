class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pet_app(pet_id, app_id)
    where("pet_id = #{pet_id} AND application_id = #{app_id}").first
  end
end