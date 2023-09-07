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

  def self.adoptable_search(search_params)
    adoptable.search(search_params)
  end

  def update_adoptable_status
    update(adoptable: false) if pet_applications.any? { |pa| pa.approval == true }
  end
end
