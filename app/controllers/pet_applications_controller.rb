class PetApplicationsController < ApplicationController
  def create
    pet_application = PetApplication.new({application: params[:application_id], params[:pet_id]})
    if pet_application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end
end