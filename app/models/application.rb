class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true
  #enum application_status: {"In Progress": 0, "Pending": 1, "Accepted":2, "Rejected":3}
  
  def in_progress?
    application_status == "In Progress"
    #use an enum vs a method at the same level as the has_many
    #validates status inclusion in progress, pending, approved
    #
  end

end 