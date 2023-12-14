class PetAppsController < ApplicationController
  def create
    PetApp.create!(application_id: params[:app_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:app_id]}"
  end

  def update
    @pet_app = PetApp.find(params[:pet_app_id])
    @app = Application.find(params[:app_id])
    if params[:new_status]
      @pet_app.update!({status: params[:new_status]})
    end
    redirect_to "/admin/applications/#{params[:app_id]}"
  end
end