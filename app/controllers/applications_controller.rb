class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def new
  end

  def create
    application = Application.create!(application_params)
    redirect_to "/applications"
  end
  
  def show
    @application = Application.find(params[:application_id])
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pet_names, status: "In Progress")
  end
end