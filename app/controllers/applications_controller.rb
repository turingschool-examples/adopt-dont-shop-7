class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not saved. Please fill in all fields."
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :description, :application_status)
  end
end