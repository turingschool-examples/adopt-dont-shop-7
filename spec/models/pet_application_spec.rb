require "rails_helper"


RSpec.describe PetApplication, type: :model do
  describe "realtionships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe "validations" do 
    it{ should validate_presence_of :application_id}
    it{ should validate_presence_of :pet_id}
    it{ should validate_presence_of :status}
  end
end