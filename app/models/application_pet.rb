class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  # def self.existing_applications(params)
  #   ApplicationPet.where(application_id: params)
  # end

end
