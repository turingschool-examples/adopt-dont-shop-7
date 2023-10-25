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

  def approvable
    raise "Only access #approvable from application instance" if pet_applications.count != 1

    pet_applications.first.status != "Approved"
  end

  def application_approved
    pet_applications.first.status == "Approved"
  end
end
