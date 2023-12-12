class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  attribute :rejected, :boolean, default: false

  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets


  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
