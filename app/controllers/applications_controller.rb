class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @matching_pets = Pet.adoptable_search(params[:pet_name])
    end
  end

  def new 
  end

  def create 
    application = Application.new(application_params) 
    if application.save 
      redirect_to "/applications/#{application.id}" 
    else 
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to "/applications/new" 
    end 
  end

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private 

  def application_params 
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
  end 
end