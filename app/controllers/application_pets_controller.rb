class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @pet = Pet.find(params[:pet_id])

    @application.pets << @pet

    redirect_to "/applications/#{@application.id}"
  end
  
  def submit_application
    @application = Application.find(params[:id])
    @application.update(status: "Pending")
    redirect_to "/applications/#{@application.id}"
    
  end
end
