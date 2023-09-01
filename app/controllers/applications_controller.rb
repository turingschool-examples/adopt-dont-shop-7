class ApplicationsController < ApplicationController
  def index
  end
  
  
  def show
    @application = Application.find(params[:app_id])
    @searched_pet = nil

    if params[:search].present?
      @searched_pet = Pet.find_by(name: params[:search])
    end
  end

  def new
    @application = Application.new
  end
  
  def create
    @application = Application.new(application_params)
    @application.status = "In Progress"
    
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end
  

  private 
    def application_params
      params.require(:application).permit(:name, :address, :city, :state, :zip, :description)
    end
  end
