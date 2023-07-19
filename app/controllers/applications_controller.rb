class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
    if params[:pet_name] != nil
      @search_pets = Pet.where("lower(name) ilike ?", "%#{params[:pet_name]}%")
    end
    if @application.pet_description != "n/a"
      @application.status = "Pending"
        
  end
end

  def new
  end

  def create 
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
      # application.update(status: "Pending")
    else 
      redirect_to "/applications/new"
      flash[:error] = "cant be blank"
    end
  end

  def update 
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def index 
    @applications = Application.all
  end


  private 

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :pet_description)
  end
end