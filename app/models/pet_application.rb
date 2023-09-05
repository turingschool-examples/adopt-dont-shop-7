class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve
    update(approval: true)
  end

  def reject
    update(approval: false)
  end
end