require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should belong_to(:shelter) }
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
end
