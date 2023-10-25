class ApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.current_app(params[:aid], params[:pid])
    application_pet.update(status: params[:status_update].to_i)
    redirect_to "/admin/applications/#{params[:aid]}"
  end
end