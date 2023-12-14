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

  def all_pets_apps_appr?
    if self.pet_applications.where('status = 2').count == self.pet_applications.count &&
      self.pet_applications.where('status = 2').count > 0
        true
    elsif self.pet_applications.where('status = 3').count > 0 &&
       (self.pet_applications.count - self.pet_applications.where('status = 3').count) == self.pet_applications.where('status = 2').count
        false
    end
  end
end