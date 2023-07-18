class AdminApplicationsController < ApplicationsController
  def show
    @applications = Application.find(params[:application_id])
  end
end