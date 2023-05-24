class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    @app_petapp = @application.pet_applications
  end

  def update
    if params[:pet_applications_status] == "Approved"
      application = PetApplication.find(params[:application_id])
      application.update(pet_applications_status: params[:pet_applications_status])
      redirect_to "/admin/applications/#{application.application_id}"
      # render :show
    elsif params[:pet_applications_status] == "Rejected"
      application = PetApplication.find(params[:application_id])
      application.update(pet_applications_status: params[:pet_applications_status])
      redirect_to "/admin/applications/#{application.application_id}"
      # render :show
    end
  end
end