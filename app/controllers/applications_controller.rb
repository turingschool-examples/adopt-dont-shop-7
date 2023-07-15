class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
  end

  def new
  end

  def create 
    application = Application.new(application_params)
    if application.save && application_params[:name] != "" && 
      application_params[:street_address] != "" && 
      application_params[:city] != "" && 
      application_params[:state] != "" && 
      application_params[:zip_code] != "" && 
      application_params[:description] != ""
      redirect_to "/applications/#{application.id}"
    else 
      redirect_to "/applications/new"
      flash[:notice] = "Error: Please fill in all fields"
    end
      application.update(status: "In Progress")
    # redirect_to "/applications/#{application.id}"
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