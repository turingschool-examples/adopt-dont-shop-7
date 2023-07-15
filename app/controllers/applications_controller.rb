class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
  end

  def new
  end

  def create 
    application = Application.create!(application_params)
    application.update(status: "In Progress")
    redirect_to "/applications/#{application.id}"
  end

  def update 
    application = Application.find(params[:id])
    application.update(application_params)
  end

  def index 
    @applications = Application.all
  end


  private 

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end