class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
    # @search_pets = Pet.where(name: params[:pet_name])
    @search_pets = Pet.where("name like ?", "%#{params[:pet_name]}%")
  end

  def new
  end

  def create 
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
      application.update(status: "In Progress")
    else 
      redirect_to "/applications/new"
      flash[:error] = "cant be blank"
    end
    # redirect_to "/applications/#{application.id}"
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
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end