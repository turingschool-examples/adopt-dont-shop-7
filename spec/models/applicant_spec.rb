require "rails_helper"

RSpec.describe Applicant, type: :model do
  describe "relationships" do
    it { should have_many(:applicant_pets) }
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:state).is_equal_to(2) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:zip_code).is_equal_to(5) }
    it { should validate_presence_of(:qualification) }
  end
end