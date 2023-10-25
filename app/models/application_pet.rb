class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  enum :status, {Pending: 0, Accepted: 1, Rejected: 2}
end
