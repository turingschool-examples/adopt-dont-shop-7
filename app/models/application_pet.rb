class ApplicationPet < ApplicationRecord
  belongs_to  :application
  belongs_to  :pet

  enum pet_status: {
    pending: 0,
    approved: 1,
    rejected: 2
  }

  def approve
    self.update(pet_status: "approved")
    application.approve if application.can_approve?
  end

  def reject
    self.update(pet_status: "rejected")
    application.reject if application.can_reject?
  end
end
