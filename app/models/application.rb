class Application < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  validates :status, presence: true
  # validates :qualifications, presence: false

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets, dependent: :destroy

  def status_in_progress
    self.status == "In Progress"
  end

  def has_pets
    self.pets.count > 0
  end
end

