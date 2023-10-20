class PetApplication < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  belongs_to :application
  belongs_to :pet
end