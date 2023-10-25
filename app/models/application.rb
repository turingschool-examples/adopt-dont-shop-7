class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  def address_join
    "#{street_address}, #{city}, #{state}, #{zip_code}"
  end

  def change_status
    check_values = application_pets.map{|pet| pet.status}
    if !check_values.include?(nil) && !check_values.include?(false)
      self.update(status: "Approved")
    elsif check_values.include?(false)
      self.update(status: "Rejected")
    end
  end

end