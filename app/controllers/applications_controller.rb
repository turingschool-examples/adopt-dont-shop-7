class ApplicationsController < ApplicationController
  def show 
    @app = Application.find(params[:id]) 
    @pets = @app.pets
  end 

  def new; end

  def create
    new_app = Application.create!(strong_params)
    redirect_to "/applications/#{new_app.id}"
  end

  private 

  def strong_params
    params.permit(:name,
                  :street_address,
                  :city, 
                  :state,
                  :zip,
                  :description)
  end
end 