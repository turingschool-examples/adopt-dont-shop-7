class PetApplication < ApplicationRecord
  validates_presence_of :status
  validates :pet_id, presence: true, numericality: true
  validates :application_id, presence: true, numericality: true

  belongs_to :pet
  belongs_to :application

  def initialize(params)
    super(params)
    self.status = "Pending"
  end
end
