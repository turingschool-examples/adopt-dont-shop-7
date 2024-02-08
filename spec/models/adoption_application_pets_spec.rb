require 'rails_helper'

RSpec.describe AdoptionApplicationPets, type: :model do
   describe 'relationships' do
      it {should belong_to :adoption_application}
      it {should belong_to :pets}
   end
end