class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create 
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end
end

private

def application_params
  params.permit(:name, :street_address, :city, :state, :zipcode, :description, :application_status)
end