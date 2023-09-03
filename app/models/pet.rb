class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end
end
