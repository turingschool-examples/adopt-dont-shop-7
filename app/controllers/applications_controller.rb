class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = PetApplication.where(application: @application.id)
  end


end