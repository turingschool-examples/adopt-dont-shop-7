class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :adopting_reason, presence: true
  
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.num_of_applications
    self.count
  end
  
  def populate_address
    "#{street_address}, #{city}, #{state}, #{zip_code}"
  end
end