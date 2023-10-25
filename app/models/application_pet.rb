class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  enum :status, {Pending: 0, Accepted: 1, Rejected: 2}

  def self.current_app(application_id, pet_id)
    where('application_id = ?', application_id).where('pet_id = ?', pet_id)
  end

  def pending?
    self.status == "Pending"
  end
end
