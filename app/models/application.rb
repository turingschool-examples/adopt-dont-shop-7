class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates_inclusion_of :status, in: ["In Progress", "Pending", "Accepted", "Rejected"]
end