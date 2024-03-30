class PetApplicationsController < ApplicationsController
  def create
    PetApplication.create(application_id: params[:id], pet_id: params[:pet_id]) 
    redirect_to "/applications/#{params[:id]}"
  end

end