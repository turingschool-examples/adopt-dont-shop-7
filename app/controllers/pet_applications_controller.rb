class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_application = PetApplication.find(params[:id])
    pet_application.status = "Approved"
    pet_application.save
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private

  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end
