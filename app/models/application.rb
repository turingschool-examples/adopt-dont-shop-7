class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true

  enum status: {
    in_progress: 0,
    pending: 1,
    approved: 2,
    rejected: 3
  }
  has_many  :application_pets
  has_many  :pets, through: :application_pets

  def submit_reason_for_adoption(reason)
    self.reason_for_adoption = reason
    self.status = "pending"
    self.save!
  end

  def can_approve?
    application_pets.where(pet_status: "approved").count == application_pets.count
  end

  def approve
    # if can_approve?
      self.approved!
      # make pets not adoptable
      # pets.each { |pet| pet.not_adoptable! }
       pets.update_all(adoptable: false)
    # end
  end

  def can_reject?
    application_pets.where(pet_status: "rejected").any?
  end

  def reject
    # if can_reject?
      self.rejected!
    # end
  end
end
