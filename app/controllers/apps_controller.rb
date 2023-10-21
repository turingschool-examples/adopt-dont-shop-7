class AppsController < ApplicationController
  def index
    @apps = App.all
  end
  
  def new
    @app = App.new
  end

  def show
    @apps = App.find(params[:id])
  end

  def create
    app = App.create(app_params)
    redirect_to "/apps/#{app.id}"
  end

  private
  def app_params
    params.permit(:name, :address, :city, :zip, :description)
  end
end