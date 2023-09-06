class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :pet_applications, through: :pets
  has_many :applications, through: :pet_applications

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.order_by_reverse_alphabetical
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.pending_apps
    joins(:applications).where("status = 'Pending'")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where("age >= ?", age_filter)
  end

  def self.alphabetical_order
    order(name: :asc)
  end

  def self.shelters_with_pending_apps
    joins(:pet_applications)
      .where('pet_applications.application_status = ?', 'Pending')
      .distinct
  end
end
