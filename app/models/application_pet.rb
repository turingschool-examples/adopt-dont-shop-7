class ApplicationPet < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true

  belongs_to :application
  belongs_to :pet

  def set_application_approved
    require 'pry'; binding.pry
    self.application_approved = true
    self.save
  end

  def set_application_denied
    require 'pry'; binding.pry
    self.application_approved = false
    self.save
  end

  def approve_or_deny(filter, application_id, pet_id)
    if filter == "approved"
      set_application_approved
    else
      set_application_denied
    end
  end

  # Use this class method to find the application with a matching application_id and pet_id
  def self.find_application_pet(application_id, pet_id)
    ApplicationPet.where("application_id = ? AND pet_id = ?", application_id, pet_id)
  end
end
