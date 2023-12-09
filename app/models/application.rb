class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name, :street_address, 
    :city, :state, :zip_code

  # def app_status(pet)
  #   pet_app = PetApplication.select("pet_applications.*").where("application_id = #{self.id} AND pet_id = #{pet.id}")
  #   status = pet_app.status

  # end

end