class ApplicationsController < ApplicationController
  def index
    @application = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    search_term = params[:search]
    @search_results = Pet.search(search_term)
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Add a Pet to this Application"
      render :new
    end
  end

  private 
  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end
