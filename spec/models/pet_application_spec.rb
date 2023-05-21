require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:pet_id) }
    it { should validate_presence_of(:application_id) }
    it { should validate_numericality_of(:pet_id) }
    it { should validate_numericality_of(:application_id) }
  end
end
