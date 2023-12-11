class Admins::ApplicationsController < ApplicationController

  def show
    @application = Application.application(params[:id])
    if params[:filter].present?
      pet_application = Application.approve_or_deny_application_pet(params[:pet_id], params[:id], params[:filter])
    end
  end
end
