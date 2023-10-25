class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approved(application_id)
    if status == true
      return true if application_id == self.application_id
      false if application_id != self.application_id
    end
  end

  def rejected(application_id)
    if status == false
      return true if application_id == self.application_id
      false if application_id != self.application_id
    end
  end

  def approve
    self.update(status: true)
  end

  def reject
    self.update(status: false)
  end

end