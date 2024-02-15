class ApplicationPetsController < ApplicationController

  def create
    params[:pet_reason] ||= "N/A"
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    pet_reason = params[:pet_reason]
    ApplicationPet.create(application_id: application.id, pet_id: pet.id, pet_reason: pet_reason)

    redirect_to "/applications/#{application.id}"
  end

  def update
    
  end
end