class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
 
  validates_presence_of :name, :street, :city, :state, :zip, :descr, :status

  enum status: {"In progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3}

  def pet_search(name)
    Pet.where("name = ?", name)
  end

  def get_pet_app(pet_id) 
    PetApplication.where(pet_id: pet_id, application_id: self.id).first
  end

  def get_app_status 
    return "Rejected" if self.pet_applications.where("status = 3").any?
    return "Pending" if self.pet_applications.where("status = 1").any?
    return "Approved"
  end
end