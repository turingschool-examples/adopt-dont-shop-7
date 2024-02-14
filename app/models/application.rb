class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  has_many :shelters, through: :pets
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :endorsement, presence: true

  def find_pets
    @pets = Pet.joins(:applications).where("applications.id = #{self.id}")
  end

  def has_pets?
    find_pets.count > 0
  end

  def in_progress?
    status == "In Progress"
  end

  
end