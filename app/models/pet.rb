class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :applicant_pets
  has_many :applicants, through: :applicant_pets

  validates :name, presence: true
  validates :age, presence: true, numericality: true

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
