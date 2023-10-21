class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def address
    "#{self.street_address}, #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def pet_status(petid)
    pet_applications = PetApplication.where(application_id: self.id, pet_id: petid)
 
    pet_applications.first.status if pet_applications.first.status != nil
  end
end