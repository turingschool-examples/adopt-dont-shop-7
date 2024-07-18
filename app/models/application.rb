class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy

  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true


  # use this enum sytnax for future user story? enum :status, [:shipped, :being_packed, :complete, :cancelled]
end