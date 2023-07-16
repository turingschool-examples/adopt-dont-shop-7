class ShelterApplicationsController < ApplicationController
  def index
    @application = Application.find(params[:application_id])
    @shelter = Shelter.includes(:applications).find(params[:shelter_id])
    @shelters_with_pending_applications = Shelter.pending_applications
  end
end