class ApplicationPet < ApplicationRecord
  belongs_to  :application
  belongs_to  :pet

  enum pet_status: {
    pending: 0,
    approved: 1,
    rejected: 2
  }

  def approve
    self.pet_status = "approved"
    self.save!
    application.approve if application.can_approve?
  end

  def reject
    self.pet_status = "rejected"
    self.save!
    application.reject if application.can_reject?
  end


end
