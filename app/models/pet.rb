class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :apps_pets
  has_many :apps, through: :apps_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search_params) 
    where("name ILIKE ?", "%#{search_params}%")
  end
end
