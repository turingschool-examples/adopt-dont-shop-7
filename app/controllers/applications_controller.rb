class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    @application = Application.create!(app_params)
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pets, :status, :shelter)
  end
end