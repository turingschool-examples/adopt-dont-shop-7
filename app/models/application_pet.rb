class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def status_update
    self.state = ((application.status == "Approved") && (pet.adoptable))
  end
end