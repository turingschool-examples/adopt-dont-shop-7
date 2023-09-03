class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pets_applications
  has_many :applicants, through: :pets_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.pets_with_app_status(application)
    joins(applicants: :pets_applications)
    .where('pets_applications.applicant_id = ?', application.applicant_id)
    .select("pets_applications.status", "pets.name", "pets.id")
    .distinct
  end

  def self.pets_with_app_status_by_sql(application)
    find_by_sql("SELECT pets.name, pets.id, pets_applications.status FROM pets 
    JOIN pets_applications on pets.id = pets_applications.pet_id 
    JOIN applicants on applicants.id = pets_applications.applicant_id 
    WHERE pets_applications.applicant_id = #{application.applicant_id}")
  end
end
# update