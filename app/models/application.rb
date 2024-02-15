class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

    validates :name, presence: true
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true 
    validates :zipcode, presence: true 
    validates :description, presence: true

  def pending
    update(application_status: "Pending")
  end
end