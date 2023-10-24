class AdminShelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  @app_shelter = Pet.joins(:pet_applications)
    # require'pry';binding.pry
  @shelter_num = []
  @app_shelter.each do |pet|
    @shelter_num << pet.shelter_id
  end

end