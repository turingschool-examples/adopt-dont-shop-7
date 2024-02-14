class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    
    if params[:approve]
      @application.update(status: "Approved") 
    elsif params[:reject]
      @application.update(status: "Rejected") 
    end
    
    @application_pet = ApplicationPet.find_by(
      application_id: params[:id], 
      pet_id: params[:pet_id]
      )
    @result = @application_pet&.status_update
    
    render :show
  end
end