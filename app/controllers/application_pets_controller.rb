class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create(pet_id: params[:pet_id], application_id: params[:application_id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    status = ApplicationPet.find(params[:id])
    status.update(app_pet_status: params[:app_pet_status])

    redirect_to "/admin/applications/#{status.application_id}"
  end
end