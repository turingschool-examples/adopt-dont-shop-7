class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications, dependent: :destroy

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.filter_by_name(threshold)
    where("name ILIKE ?", "%#{threshold}%")
  end

  def approved?
    self.approved
  end

end
