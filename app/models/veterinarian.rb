class Veterinarian < ApplicationRecord
  validates :name, presence: true
  validates :review_rating, presence: true, numericality: true
  belongs_to :veterinary_office

  def office_name
    veterinary_office.name
  end

  def self.on_call
    where(on_call: true)
  end

  def self.generate_fake_data
    Veterinarian.create!(
      on_call: Faker::Boolean.boolean,
      review_rating: Faker::Number.within(range: 1..5),
      name: Faker::Name.name,
      veterinary_office_id: VeterinarianOffice.all.sample
    )
  end
end
