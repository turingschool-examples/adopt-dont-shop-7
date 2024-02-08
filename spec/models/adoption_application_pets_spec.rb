require 'rails_helper'

RSpec.describe AdoptionApplicationPet, type: :model do
   describe 'relationships' do
      it {should belong_to :adoption_application}
      it {should belong_to :pet}
   end
end