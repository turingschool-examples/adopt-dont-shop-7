class AdoptionApp < ApplicationRecord
  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true

  has_and_belongs_to_many :pets

  def adoption_status
    params[:status] = "In Progress"
    #if the application is submitted, it changes status to "In Progress"/defaults to "In Progress"
    #if the application is submitted AND approved, it changes status to "Approved"
    #If the application is submitted AND rejected, it changes status to "Rejected"
    
  end
end