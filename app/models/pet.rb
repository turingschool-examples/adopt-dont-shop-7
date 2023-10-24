class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.update_adoptable(application_id)
    pets_adopted = Pet.joins(:application_pets).where("application_pets.application_id = #{application_id}").distinct
    pets_adopted.each do |pet|
      pet.update({
        adoptable: false
      })
    end
  end

  def self.update_rejected_apps(application)
    adopted_pets = application.pets
    adopted_pets.each do |pet|
      app_pets = ApplicationPet.where("pet_id = ?", pet.id)
      app_pets.each do |app_pet|
        unless app_pet.application_id == application.id
          app_pet.update({
            approved: false
          })
        end
      end
    end
  end
end
