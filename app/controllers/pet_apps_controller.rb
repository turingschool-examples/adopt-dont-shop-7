class PetAppsController < ApplicationController 
  def create
    PetApp.create!(application_id: params[:app_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:app_id]}"
  end

  def update
    pet_app = PetApp.find(params[:id])
    if params[:approve]
      pet_app.update!(pet_status: 1)
    else
      pet_app.update!(pet_status: 2)
    end
    redirect_to "/admin/applications/#{pet_app.application.id}"
  end
end