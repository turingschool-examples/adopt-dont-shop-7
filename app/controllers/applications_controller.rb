class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    @app_petapps = PetApplication.find_applications(@application.id)
  end
end