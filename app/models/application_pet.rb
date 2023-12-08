class ApplicationPet < ApplicationRecord
  # belongs_to :shelter
  belongs_to :application
  belongs_to :pet
end
