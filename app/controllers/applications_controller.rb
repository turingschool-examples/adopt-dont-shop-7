class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:search_for_pet]
      #@found_pet = Pet.find_by(name: params[:search_for_pet]) obsolete at user story 8
      # @found_pet = Pet.where("name LIKE ?", "%#{params[:search_for_pet]}%") obsolete at user story 9
      @found_pet = Pet.where("lower(name) LIKE ?", "%#{params[:search_for_pet].downcase}%") 
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not saved. Please fill in all fields."
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(application_status: "Pending", description: params[:description])
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :description, :application_status)
  end
end