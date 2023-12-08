class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :status, presence: true

  has_many :pets
  belongs_to :shelter
end
