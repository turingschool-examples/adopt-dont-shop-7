class ApplicationPetsController < ApplicationController
  def new
  end

  def create
    application_pet = ApplicationPet.new(application_id: params[:application_id], pet_id: params[:pet_id], status: "In Progress")
   
    if application_pet.save
      redirect_to "/applications/#{params[:application_id]}"
    else 
      redirect_to "/applications/#{params[:application_id]}"
      flash[:alert] = "Error: #{error_message(application_pet.errors)}"
    end
  end
end