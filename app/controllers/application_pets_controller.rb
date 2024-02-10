class ApplicationPetsController < ApplicationController
  def new; end

  def create
    pet = Pet.find(params[:pet_key])
    application = Application.find(params[:id])
    ApplicationPet.create(pet_id: pet.id, application_id: application.id)
    redirect_to "/applications/#{application.id}"
  end
end
