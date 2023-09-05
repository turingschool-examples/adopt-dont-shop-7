class PetsApplication < ApplicationRecord
  belongs_to :pet, optional: true
  belongs_to :applicant

  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  # def self.find_application_for_approve(pet_id, app_id)
  #   find_by_sql("SELECT * FROM pets_applications
  #               WHERE applicant_id = #{app_id} and pet_id = #{pet_id}")
  # end

  def self.find_application(pet_id, app_id)
    where("applicant_id = ? AND pet_id = ?", app_id, pet_id)
  end

  # def self.check_if_pending(app)
  #   PetsApplication.joins(:applicant).where('applicant_id = ?', app.id).exists?(status: "Pending")
  # end

  # def self.check_if_rejected(app)
  #   PetsApplication.joins(:applicant).where('applicant_id = ?', app.id).exists?(status: "Rejected")
  # end

  def self.check_app_status(applicant)
    if PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Pending")
      "Pending"
    elsif PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Rejected")
      "Rejected"
    elsif PetsApplication.where('applicant_id = ?', applicant.id).exists?(status: "Accepted")
      "Approved"
    else
      "In Progress"
    end
  end
end