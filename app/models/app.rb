class App < ApplicationRecord
  validates :name, :address, :city, :zip, :description, presence: true
  has_many :apps_pets
  has_many :pets, through: :apps_pets

  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
end