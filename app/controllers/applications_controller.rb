class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets_app = PetsApplication.where(application: @application.id)
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "Please Fill Out Entire Form"
      redirect_to "/applications/new"
    end
  end

  def search
    show
    @query = Pet.where(name: params[:search])
  end

  def update
    search
    @pet = search.first
    @application = Application.find(params[:id])
    redirect_to "/applications/#{params[:id]}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :description, :status)
  end
end