class ApplicationsController < ApplicationController
  def index
  end
  
  
  def show
    @application = Application.find(params[:app_id])

    if params[:search].present?
      @searched_pets = Pet.where("lower(name) LIKE ?", "%#{params[:search].downcase}%") 
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

  def update
    application = Application.find(params[:app_id])
    application.update({
      description: params[:reason],
      status: [params[:app_status]]
    })
    application.save
    redirect_to "/applications/#{application.id}"
  end

  def add_pet
    application = Application.find(params[:app_id])
    application.add_pet(params[:pet_id])
    redirect_to "/applications/#{application.id}"
  end

  private 
    def application_params
      params.require(:application).permit(:name, :address, :city, :state, :zip, :description)
    end
  end
