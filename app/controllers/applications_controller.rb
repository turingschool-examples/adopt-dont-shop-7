class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    @application = Application.new(app_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: You must complete all fields"
    end
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pets, :status, :shelter)
  end
end