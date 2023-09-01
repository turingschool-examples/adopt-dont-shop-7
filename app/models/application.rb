class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def address
    "#{self.street_address}, #{self.city}, #{self.state} #{self.zip_code}"
  end
end