class ApplicationsController < ApplicationController

  def new; end

  def create 
    new_app = Application.create!(app_params)
    new_app.update!(status: 0)
    redirect_to "/applications/#{new_app.id}"
  end

  def show
    @app = Application.find(params[:id])
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description)
  end
  
end