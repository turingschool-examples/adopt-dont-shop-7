class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @pet = Pet.find(params[:pet_id])
    @pet_application = PetApplication.new({
      application_id: params[:application_id], 
      pet_id: params[:pet_id], 
      status: "Pending"
    })
    @pet_application.save
    
    redirect_to "/applications/#{@application.id}"
  end
end