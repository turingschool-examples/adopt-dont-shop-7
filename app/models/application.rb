class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true

  has_many  :application_pets
  has_many  :pets, through: :application_pets

  enum status: {
    in_progress: 0,
    pending: 1,
    approved: 2,
    rejected: 3
  }

  def submit_reason_for_adoption(reason)
    self.update(reason_for_adoption: reason, status: "pending")
  end

  def can_approve?
    application_pets.where(pet_status: "approved").count == application_pets.count
  end

  def approve
      self.approved!
      pets.update_all(adoptable: false)
  end

  def can_reject?
    application_pets.where(pet_status: "rejected").any?
  end

  def reject
    self.rejected!
  end
end
