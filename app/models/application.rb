class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :applicant_name, :street_address, 
          :city, :state, :zip_code, :description, :status 

  def update_status
    if pet_applications.all? { |pa| pa.approval == true }
      update(status: "Approved")
    elsif pet_applications.any? { |pa| pa.approval == false }
      update(status: "Rejected")
    end
  end
end