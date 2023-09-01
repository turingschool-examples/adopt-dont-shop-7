require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
    it { should validate_presence_of :applicant_name }
    it { should validate_presence_of :full_address}
    it { should validate_presence_of :application_status }
    it { should validate_presence_of :description }
  end
end