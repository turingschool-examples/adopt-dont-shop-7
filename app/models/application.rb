class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  validates :status, presence: true
  # inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  def full_address
    "#{address}, #{city}, #{state}, #{zip}"
  end

  def pet_names
    pets.pluck(:name)
  end

  def pet_status
    pet_applications.pluck(:pet_id, :status).to_h
  end

  def pet_approved(id)
    pet_status[id] == "Approved" && !pet_status[id].nil?
  end

  def pet_rejected(id)
    pet_status[id] == "Rejected" && !pet_status[id].nil?
  end
end
