class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_reverse_alpha
    require 'pry'; binding.pry
    order(created_at: :desc)
  end
end