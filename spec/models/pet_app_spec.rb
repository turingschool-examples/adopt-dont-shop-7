require 'rails_helper'

RSpec.describe PetApp, type: :model do

  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
end