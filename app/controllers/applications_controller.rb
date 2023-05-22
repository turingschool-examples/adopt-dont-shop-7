class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @searched_pets = Pet.search(params[:search]) if params[:search].present?
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: ALL sections must be completed"
    end
  end

  def update 
    application = Application.find(params[:id])
    application.update(application_params)
    application.update(status: "Pending")
    redirect_to "/applications/#{application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status, :reason)
  end
end