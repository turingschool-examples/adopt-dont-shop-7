require "rails_helper"

RSpec.describe PetsApplication, type: :model do
  describe "relationships" do
    it { should belong_to(:pet).optional }
    it { should belong_to(:applicant) }
  end
end