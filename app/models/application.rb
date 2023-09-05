class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :reason_for_adoption, presence: true
  validates :status, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def find_pet_application_status(pet)
    self.pet_applications.where("pet_id = #{pet}").pluck(:application_status).first
  end
end