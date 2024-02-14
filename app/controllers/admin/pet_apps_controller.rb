class Admin::PetAppsController < ApplicationController 
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