class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.new(application_pets_params)
  end

  private
  def application_pets_params
    params.permit(:application_id, :pet_id)
  end
end