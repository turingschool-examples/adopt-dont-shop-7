class Admin::ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = Application.search(params[:pet_id], params[:id])
    if pet_application.update(shelter_params)
      redirect_to "/admin/applications/#{applications.id}"
    else
      redirect_to "/admin/applications/#{applications.id}"
      flash[:alert] = "Error: #{error_message(pet_application.errors)}"
    end
  end

end






