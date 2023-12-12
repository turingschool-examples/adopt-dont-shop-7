class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum status: { "In progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3 }

  def update_pet_status(button)
    if button == "Approve"
      self.update!(status: 2)
    elsif button == "Reject"
      self.update!(status: 3)
    else
      self
   end
  end

end