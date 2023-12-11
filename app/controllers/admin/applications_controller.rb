class Admin::ApplicationsController < ApplicationController
  
  def approve_pet
    application = Application.find(params[:application_id])
    pet_application = application.pet_applications.find_by(pet_id: params[:pet_id])
    pet_application.approve
    redirect_to "/admin/applications/#{application.id}"
  end

  def reject_pet
    application = Application.find(params[:application_id])
    pet_application = application.pet_applications.find_by(pet_id: params[:pet_id])
    pet_application.reject
    redirect_to "/admin/applications/#{application.id}"
  end


  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def index
    @applications = Application.all
  end

end