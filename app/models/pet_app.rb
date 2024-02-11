class PetApp < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum pet_status: ['Pending', 'Accepted', 'Rejected']
end
