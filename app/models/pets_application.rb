class PetsApplication < ApplicationRecord
  belongs_to :pet, optional: true
  belongs_to :applicant

  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]
  
  def self.find_application(pet_id, app_id)
    where("applicant_id = ? AND pet_id = ?", app_id, pet_id)
  end

  def self.check_app_status(applicant)
    if PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Pending")
      "Pending"
    elsif PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Rejected")
      "Rejected"
    elsif PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Accepted")
      "Approved"
    # else
    #   "In Progress"
    end
  end

  def self.all_apps_for_applicant(application)
    where('applicant_id = ?', application.applicant_id)
  end

end