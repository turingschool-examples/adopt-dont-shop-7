class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    
  end

  def update
    @application = Application.find(params[:id])
    #1. if statement for button so it will disappear once pet adopted
    #2. make a column in pet_applications
    #3. finish this update method to populate that column
    redirect_to "/applications/#{@application.id}"
  end
end