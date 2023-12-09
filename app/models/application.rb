class Application < ApplicationRecord
  validates_the_presence_of :name, :full_address, :description, :status

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']

  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps
end