class Pet < ApplicationRecord
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.adoptable_search(search_params)
    adoptable.search(search_params)
  end
end
