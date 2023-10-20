class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.create(app_params)
    # application.create!(app_params)
    # require 'pry'; binding.pry
    redirect_to("/applications/#{application.id}")
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip_code, :description)
  end
end