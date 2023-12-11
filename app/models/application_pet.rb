class ApplicationPet < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true

  belongs_to :application
  belongs_to :pet

  def set_application_approved
    self.application_approved = true
    self.save
  end

  def set_application_denied
    self.application_approved = false
    self.save
  end

  def approve_or_deny(filter)
    if filter == "approved"
      set_application_approved
    else
      set_application_denied
    end
  end
end
