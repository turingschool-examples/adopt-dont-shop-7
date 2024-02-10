class ApplicationPetsController < ApplicationController
  
  def new
  end

  def create
    @application_pet = ApplicationPet.new(application_pets_params)
    @application_pet.save
    redirect_to "/applications/#{@application_pet.application_id}"
  end

  private
  def application_pets_params
    params.permit(:application_id, :pet_id)
  end
end