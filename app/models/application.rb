class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { "In Progress" => 0, "Pending" => 1, "Accepted" => 2, "Rejected" => 3 }
  def full_address
    street_address << " " << city << ", " << state << " " << zipcode
  end

  def added_pets?
    self.pets.present?
  end

  def all_pets_approved?
    !self.application_pets.pluck(:application_approved).include?(false)
  end

  def all_applications_reviewed?
    !self.application_pets.pluck(:application_reviewed).include?(false)
  end

  def number_of_pets
    self.pets.count
  end

  def yes_or_no(true_or_false)
    true_or_false ? "Yes" : "No"
  end
end
