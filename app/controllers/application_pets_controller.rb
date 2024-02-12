class ApplicationPetsController < ApplicationController

  def create
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    ApplicationPet.create(application_id: application.id, pet_id: pet.id)

    redirect_to "/applications/#{application.id}"
  end

end

