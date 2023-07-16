class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  has_and_belongs_to_many :adoption_apps

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
