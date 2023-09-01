class PetsApplication < ApplicationRecord
  belongs_to :pet, optional: true
  belongs_to :applicant


end
