class ApplicationsController < ApplicationController
  def show 
    @app = Application.find(params[:id]) 
    @pets = @app.pets
  end 
end 