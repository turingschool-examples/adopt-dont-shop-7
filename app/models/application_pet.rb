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

  after_update :update_pet
  after_update :update_application

  def pet_adopted?
    pet = Pet.find(self[:pet_id])
    !pet.adoptable?
  end

  private

  def update_pet
    if application_approved && application.all_pets_approved?
      application.pets.each do |pet|
        pet.update!(adoptable: false)
      end
    end
  end

  def update_application
    application.update!(status: 2) if application_approved
  end

  # def self.all_pets_approved?(application_id)
  #   ApplicationPet.joins(:pet)
  #                 .where(application_id: application_id)
  #                 .pluck('MIN (application_approved)')
  #                 .first
  # end
end
