class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @searched_pets = Pet.search(params[:search_pet]) if params[:search_pet].present?
  end

  def new
  end

  def create
    @application = Application.new(app_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: You must complete all fields"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(app_params)
    redirect_to("/applications/#{@application.id}")
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pets, :status, :shelter)
  end
end