class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street, :city, :state, :zip, :description, presence: true
  validates :zip, length: { is: 5 }
  validates :state, length: { is: 2, message: "Please use 2 letters for the state abbreviation" }

  def pets?
    pets.present?
  end

  def can_submit?
    status == "In Progress" and
    pets?
  end
end

