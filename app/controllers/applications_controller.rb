class ApplicationsController < ApplicationController 

  def show 
    @application = Application.find(params[:id])
    if params[:pet_name] != nil
      @search_pets = Pet.search_by_name(params[:pet_name]) if params[:pet_name].present?
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


  private 

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :pet_description)
  end
end