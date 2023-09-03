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
end
# update