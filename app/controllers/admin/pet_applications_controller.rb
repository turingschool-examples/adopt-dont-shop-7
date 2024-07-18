class Admin::PetApplicationsController < ApplicationController
  def update
    @application = Application.find(params[:id])
    @pet_application = @application.pet_applications.find_by(pet_id: params[:pet_id])

    @pet_application.update(pet_app_status_params)
    redirect_to "/admin/applications/#{@application.id}"
  end

  private
  def pet_app_status_params
    params.permit(:status)
  end
end