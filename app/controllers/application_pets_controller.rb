class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:app_id])
    @pet = Pet.find(params[:pet_id])
    ApplicationPet.create!(application: @application, pet: @pet)
    
    redirect_to "/applications/#{@application.id}"   
  end

  def update
    application_pet = ApplicationPet.current_app(params[:aid], params[:pid])
    application_pet.update(status: params[:status_update].to_i)
    redirect_to "/admin/applications/#{params[:aid]}"
  end
end