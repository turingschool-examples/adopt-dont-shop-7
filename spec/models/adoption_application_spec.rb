require 'rails_helper'

RSpec.describe AdoptionApplication, type: :model do
   describe 'relationships' do
      it { should have_many :adoption_application_pets }
      it { should have_many(:pets).through(:adoption_application_pets) }
   end
end