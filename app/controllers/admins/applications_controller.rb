class Admins::ApplicationsController < ApplicationController

  def show
    @application = Application.application(params[:id])
    if params[:filter] == "approved"
      pet_application = Application.approve_or_deny_application_pet(params[:pet_id], params[:id], params[:filter])
      Pet.find(params[:pet_id]).set_adoptable_false
    elsif params[:filter].present?
      pet_application = Application.approve_or_deny_application_pet(params[:pet_id], params[:id], params[:filter])
    end
  end
end
