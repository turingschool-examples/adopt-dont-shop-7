class ApplicationPet < ApplicationRecord
  before_validation :set_default_status
  belongs_to :pet
  belongs_to :application

  def set_default_status
    self.status ||= "Pending"
  end
end