class ApplicationPetsController < ApplicationController
  def create
    ApplicationPet.create!(application_pets_params)
    redirect_to "/applications/#{application_pets_params[:application_id]}"
  end

  private
  def application_pets_params
    params.required(:application_pet).permit(:application_id, :pet_id)
  end
end