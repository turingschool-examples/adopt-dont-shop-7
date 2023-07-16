class ApplicationsController < ApplicationController
  def index
    @application = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @search_results = Pet.search(params[:search])
    else
      @search_results = []
    end
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private 
  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status, :description_owner)
  end
end
