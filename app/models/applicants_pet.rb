class ApplicantsPet < ApplicationRecord
  belongs_to :applicant
  belongs_to :pet
  validates :status, presence: true





end