class ApplicationPetsController < ApplicationController

  def create
    application_pet = ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{application_pet.application_id}"
  end

  def update
    application_pet = ApplicationPet.find(params[:id])
    application_pet.update(application_pet_params)
    application = application_pet.application
    redirect_to "/admin/applications/#{application.id}"
  end
  
  private
  def application_pet_params
    params.require(:application_pet).permit(:application_id, :pet_id, :status)
  end

end