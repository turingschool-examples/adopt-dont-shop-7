class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update 
    application_pet = ApplicationPet.find_application_pet(params[:pet_id], params[:application_id])
    application_pet.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end