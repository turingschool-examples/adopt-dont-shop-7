require 'rails_helper'

RSpec.describe Application, type: :model do
    describe "Relationships" do 
        it {should have_many :pet_applications}
    end
end