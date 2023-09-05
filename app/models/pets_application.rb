class PetsApplication < ApplicationRecord
  belongs_to :pet, optional: true
  belongs_to :applicant

  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  # def self.find_application_for_approve(pet_id, app_id)
  #   find_by_sql("SELECT * FROM pets_applications
  #               JOIN pets on pets.id = pets_applications.id
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
    if PetsApplication.joins(:applicant).where('applicant_id = ?', applicant.id).exists?(status: "Pending")
      @status = "Pending"
    elsif PetsApplication.joins(:applicant).where('applicant_id = ?', applicant.id).exists?(status: "Rejected")
      @status = "Rejected"
    else
      @status = "Approved"
    end
  end
end