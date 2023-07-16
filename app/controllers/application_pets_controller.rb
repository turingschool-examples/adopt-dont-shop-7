class ApplicationPetsController < ApplicationController
  def new
  end

  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    application_pet = ApplicationPet.new(application_id: params[:application_id], pet_id: params[:pet_id])
   
    if application_pet.save
      redirect_to "/applications/#{application.id}"
    else 
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: #{error_message(application_pet.errors)}"
    end
  end
end