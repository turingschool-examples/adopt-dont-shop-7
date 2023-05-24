class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true

  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def find_pet_app(app_id)
    self.pet_applications.where(application_id: app_id).first
  end

  def find_pet_app_id(app_id)
    self.pet_applications.where(application_id: app_id).pluck(:id).first
  end

end
