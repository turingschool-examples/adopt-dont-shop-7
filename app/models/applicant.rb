class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets

# def status_update
#   if admin updates application status to "rejected"
#     return application_status = "Rejected"

#   elseif admin updates application status to "accepted"
#     return application_status = "Accepted"

#   elseif user submits application 
#     return application_status = "In Progress"

#   end
end