class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.order_by_reverse_alphabetically
    Shelter.find_by_sql("select * from shelters order by name desc")
  end

  def self.pending_applications
    Shelter.joins(pets: :applications)
          .where("applications.status = ?", "Pending")
          .order(:name)
          .distinct
  end

  def name_and_address
    Shelter.find_by_sql("select name, city from shelters where id = #{self.id}").first
  end

  def pet_count
    self.pets.count
  end

  def adoptable_pets
    self.pets.where(adoptable: true)
  end

  def alphabetical_pets
    self.adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    self.adoptable_pets.where("age >= ?", age_filter)
  end

  def average_age_of_adoptable_pets
    self.adoptable_pets.average(:age)
  end

  def number_of_pets_adopted
    self.pets.joins(:application_pets)
            .where("application_pets.application_approved = ?", true)
            .count
  end

  def number_of_adoptable_pets
    self.adoptable_pets.count
  end
end
