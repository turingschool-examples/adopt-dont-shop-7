class ApplicationPet < ApplicationRecord
  validates :application_id, presence: true
  validates :pet_id, presence: true
  validates :application_approved, inclusion: [true, false]
  validates :application_approved, exclusion: [nil]
  validates :application_reviewed, inclusion: [true, false]
  validates :application_reviewed, exclusion: [nil]


  belongs_to :application
  belongs_to :pet
  has_many :applications, dependent: :destroy

  def pet_adopted?
    pet = Pet.find(self[:pet_id])
    !pet.adoptable?
  end
end
