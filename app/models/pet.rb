class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def approve
    self.update(adoptable: false)
  end

  def application_approved?
    applications.map{|app| app.status}.include?("Approved")
  end
end
