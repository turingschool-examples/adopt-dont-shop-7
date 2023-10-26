require 'rails_helper' 

RSpec.describe PetApplication, type: :model do 
  describe "validations" do
    it { should validate_presence_of(:status) }
  end
  describe "Relationships" do
    it{should belong_to(:pet)}
    it{should belong_to(:application)}
  end
end 