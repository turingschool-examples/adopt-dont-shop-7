class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
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

  def self.order_reverse_alphabetical
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
  end

  def self.with_pending_apps
    joins(:applications).where(applications: {status: "Pending"}).distinct.order(:name)
  end

  def self.name_by_sql(id)
    find_by_sql(["SELECT name FROM shelters where shelters.id = ?", id]).first[:name]
  end
  
  def self.city_by_sql(id)
    find_by_sql(["SELECT city FROM shelters where shelters.id = ?", id]).first[:city]
  end

  def avg_pet_age
    self.pets.average(:age).round
  end

  def adoptable_pets_total
    self.pets.where(adoptable: true).count
  end

  def adopted_pets_total
    self.pets.where(adoptable: false).count
  end

  def action_required
    self.pets.joins(:applications).where(applications: {status: "Pending"}).pluck(:name)
  end
end
