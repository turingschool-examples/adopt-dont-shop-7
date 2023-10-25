class ApplicationPet < ApplicationRecord
  belongs_to :application, dependent: :destroy
  belongs_to :pet, dependent: :destroy
end
