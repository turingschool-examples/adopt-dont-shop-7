class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    pet_application = PetApplication.new({application: application, pet: pet})
    if pet_application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end
end