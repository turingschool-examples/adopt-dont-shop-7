class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order(name: :desc)
    @shelters_with_pending_applicants = Shelter.joins(pets: { applicants_pets: :applicant })
                                               .where(applicants: { status: 'Pending' })
                                               .distinct
  end
end
