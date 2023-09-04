class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:name].present?
      @pets = Pet.search(params[:name])
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    application = Application.find(params[:id])
    application.application_status = "Pending"
    application.save
  end

private

  def application_params
    format_addy_params
    params.permit(:applicant_name, :full_address, :application_status, :description)
  end
  
  def format_addy_params
    if params[:street_address] != "" &&  
      params[:city] != "" && 
      params[:state] != "" && 
      params[:zip_code] != ""
      
      params[:full_address] = 
      params[:street_address] +"; " + 
      params[:city] + ", " + 
      params[:state] +" " + 
      params[:zip_code]
    end

    params[:application_status] = "In Progress"
  end
end