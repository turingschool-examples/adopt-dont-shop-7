class Admin::ApplicationsController < ApplicationController
  
  def approve_pet
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet.approve
    redirect_to "/admin/applications/#{application.id}"
  end

  def reject_pet
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet.reject 
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