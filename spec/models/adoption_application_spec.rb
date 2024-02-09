require 'rails_helper'

RSpec.describe AdoptionApplication, type: :model do
   describe 'relationships' do
      it { should have_many :adoption_application_pets }
      it { should have_many(:pets).through(:adoption_application_pets) }
   end

   describe 'validations' do
      it { should validates_presence_of(:name) }
      it { should validates_presence_of(:street_address) }
      it { should validates_presence_of(:city) }
      it { should validates_presence_of(:state) }
      it { should validates_presence_of(:zip_code) }
      it { should validates_presence_of(:description) }
      it { should validates_presence_of(:status) }
   end
end