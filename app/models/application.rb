class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  
  def address
    "#{self.street_address}, #{self.city}, #{self.state} #{self.zip_code}"
  end

  def searched_pets(pets)
    Pet.where("lower(name) LIKE ?", "%#{pets.downcase}%").all 
  end

  def pet_status(petid)
    pet_applications = PetApplication.where(application_id: self.id, pet_id: petid)
 
    pet_applications.first.status if pet_applications.first.status != nil
  end
end