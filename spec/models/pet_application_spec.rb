require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "Relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  
  describe ""
  it "checks for matching applications" do 
  
end