class PetApplicationsController < ApplicationController
  
  def create
    pet_application = PetApplication.new({application_id: params[:application_id], pet_id: params[:pet_id]})
    if pet_application.save
      redirect_to "/applications/#{params[:application_id]}"
    else
      redirect_to "/applications/#{params[:application_id]}"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end
end