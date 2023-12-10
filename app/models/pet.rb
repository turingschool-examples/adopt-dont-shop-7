class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def approve
    update(approved: true)
  end

  def reject
    update(approved: false)
  end
end
