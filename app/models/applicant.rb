class Applicant < ApplicationRecord

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true

  has_many :pets_applications
  has_many :pets, through: :pets_applications

  def self.retrieve_applicant(application_id)
    Applicant.find(PetsApplication.find(application_id).applicant_id)
  end

end