class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
    if @application.approved 

    elsif @application.rejected
    
    else
      
    end
  end

  def update
    @application = Application.find(params[:application_id])
    selected_pet = Pet.find(params[:pet_id])
    @application.approve_pet(selected_pet)
    redirect_to "/admin/applications/#{@application.id}"
  end
end