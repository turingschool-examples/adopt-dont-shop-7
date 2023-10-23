class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(application_id: params[:id], pet_id: params[:adopt])
    redirect_to "/applications/#{params[:id]}"
  end
end