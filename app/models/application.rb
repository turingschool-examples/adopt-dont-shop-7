class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def pets?
    pets.present?
  end

  def can_submit?
    status == "In Progress" and
    pets?
  end
end

