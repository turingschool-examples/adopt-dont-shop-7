class Application < ApplicationRecord
	validates :name, presence: true
	validates :street_address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :description, presence: true

	enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']

	has_many :pet_apps, dependent: :destroy
	has_many :pets, through: :pet_apps
end

