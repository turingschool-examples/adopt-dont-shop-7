class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications


  #Let's refactor this later.  These can be more specific ie integers and strings
  #Makes sure the form has everything filled out

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def add_pet(pet_id)
    pet = Pet.find(pet_id)
    self.pets << pet
  end
end