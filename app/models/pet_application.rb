class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  # require 'pry'; binding.pry
end