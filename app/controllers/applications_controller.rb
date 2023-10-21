class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{params[:application_id]}"
    else 
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end
  
  def show
    @application = Application.find(params[:application_id])
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pet_names, status: "In Progress")
  end
end
