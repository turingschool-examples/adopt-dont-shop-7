class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    @app_petapp = @application.pet_applications
  end

  def update
    application = PetApplication.find(params[:application_id])
    application.update(pet_applications_status: params[:pet_applications_status])
    redirect_to "/admin/applications/#{application.application_id}"
  end
end