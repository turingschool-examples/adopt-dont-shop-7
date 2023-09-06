class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC;") #order(name: :desc)
    @shelters_with_pending_applicants = Shelter.joins(pets: { applicants_pets: :applicant })
                                               .where(applicants: { application_status: 'Pending' })
                                               .distinct
  end
end
