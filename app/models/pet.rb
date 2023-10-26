class Pet < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
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

  def self.search_for_pet(search)
    where('lower(name) like ?', "%#{search.downcase}%")
  end

  # def application_pet(application)
  #   ApplicationPet.where("pet_id = #{self.pet_id} and application_id = #{application.id}").first
  # end

  def application_pet_status
    self.application_pets.first.application_pet_status
  end

  def self.all_accepted
    where("application_pets.application_pet_status = 'accepted'")
  end

  def self.all_rejected
    where("application_pets.application_pet_status = 'rejected'")
  end
end
