class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    # binding.pry
    redirect_to "/applications/#{@application.id}"
  end


private

  def application_params
    params[:full_address] = params[:street_address] + "; " + params[:city] + ", " + params[:state] + " " + params[:zip_code]
    params[:application_status] = "In Progress"
    params.permit(:applicant_name, :full_address, :application_status, :description)
  end
end