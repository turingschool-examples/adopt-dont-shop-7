class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve
    update(status: 'Approved')
  end

  def reject
    update(status: 'Rejected')
  end
end