class Application < ApplicationRecord
  belongs_to :shelter
  has_many :pets, through: :shelter
  
end
