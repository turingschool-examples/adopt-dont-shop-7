class ApplicationsController < ApplicationController
  def index
    if 
      params[:search].present?
    else
      "That pet does not exist"
    end
  end
  
  
  def show
    @application = Application.find(params[:app_id])
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
