require "rails_helper"

RSpec.describe PetApplicant, type: :model do
  describe "relationships" do
    it { should belong_to(:pet).optional }
    it { should belong_to(:applicant) }
  end

  describe "validations" do 
    it { should validate_numericality_of(:pet_id) }
    it { should validate_numericality_of(:applicant_id) }
  end
end