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

  def self.check_overall_status(application)
    uniformity = joins(:applicant)
                .where("pets_applications.applicant_id = #{application.applicant_id}")
                .select('status')
                .distinct
                .count
    if uniformity == 1
      true
    else
      false
    end
  end
end