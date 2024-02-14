class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

    validates :name, presence: true
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true 
    validates :zipcode, presence: true 
    validates :description, presence: true
    # validates :application_status, presence: true


end





# length: { is: 2 }
# length: { is: 5 }, numericality: { only_integer: true }