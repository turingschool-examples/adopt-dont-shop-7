class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    @app_petapps = PetApplication.where("application_id = #{@application.id}")
  end
end