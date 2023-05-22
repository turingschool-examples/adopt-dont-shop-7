class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true, numericality: false
  validates :state, presence: true, length: { is: 2 }, numericality: false
  validates :zip_code, presence: true, length: { is: 5}, numericality: true
  validates :qualification, presence: true

  has_many :applicant_pets
  has_many :pets, through: :applicant_pets

  # def search_pet
  #   Pet.where("name = ?", params[:search])
  # end

# def status_update
#   if admin updates application status to "rejected"
#     return application_status = "Rejected"

#   elseif admin updates application status to "accepted"
#     return application_status = "Accepted"

#   elseif user submits application 
#     return application_status = "In Progress"

#   end
end