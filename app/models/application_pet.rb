class ApplicationPet < ApplicationRecord
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

  def self.check_for_application_pet_approval(application_id, pet_id)
    ApplicationPet.select(:application_approved).where(application_id: application_id, pet_id: pet_id).pluck(:applicaiton_approved).first
  end

  def self.approve_or_deny_application_pet(pet_id, application_id, filter)
    application_pet_id = ApplicationPet.where(pet_id: pet_id, application_id: application_id).pluck(:id).first
    application_pet = ApplicationPet.find(application_pet_id)
    application_pet.approve_or_deny(filter)
  end

  private

  def approve_or_deny(filter)
    if filter == "approved"
      set_application_approved
    else
      set_application_denied
    end
  end
end
