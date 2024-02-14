class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def status_update
    state = ((application.status == "Approved") && (pet.adoptable))
  end
end