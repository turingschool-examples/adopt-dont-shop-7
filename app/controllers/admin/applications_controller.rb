class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @application.update(status: "Approved")
    
    @application_pet = ApplicationPet.where(
      application_id: params[:id], 
      pet_id: params[:pet_id]
      ).first
      
    @application_pet.status_update
    
    render :show
  end
end